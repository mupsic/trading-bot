#!/usr/bin/env python3
"""
Weekly Review AI routine — versión Anthropic API (para GitHub Actions).
Viernes después del cierre. Analiza la semana, propone ajustes, escribe WEEKLY-REVIEW.md.
"""

import os
import sys
import json
import subprocess
import datetime
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATE = datetime.date.today().isoformat()
TODAY = datetime.date.today()
MONDAY = TODAY - datetime.timedelta(days=TODAY.weekday())
# OPERATING_CAPITAL_ENV: límite manual si está en .env (0 = usar equity real de Alpaca)
OPERATING_CAPITAL_ENV = int(os.environ.get("OPERATING_CAPITAL", "0"))

# ------------------------------------------------------------

def bash(cmd):
    try:
        out = subprocess.run(cmd, shell=True, capture_output=True, text=True, cwd=ROOT, timeout=30)
        return out.stdout.strip()
    except Exception as e:
        print(f"[WARN] bash failed: {cmd} ({e})", file=sys.stderr)
        return ""

def jsonable(text, default):
    try:
        return json.loads(text) if text else default
    except json.JSONDecodeError:
        return default

def telegram_send(msg):
    subprocess.run(["bash", str(ROOT / "scripts/telegram.sh"), "send", msg], cwd=ROOT, capture_output=True)

def telegram_alert(level, msg):
    subprocess.run(["bash", str(ROOT / "scripts/telegram.sh"), "alert", level, msg], cwd=ROOT, capture_output=True)

def read_memory(name):
    p = ROOT / "memory" / name
    return p.read_text() if p.exists() else ""

# ------------------------------------------------------------
# Verify env
# ------------------------------------------------------------

required = ["ALPACA_API_KEY", "ALPACA_API_SECRET", "FINNHUB_API_KEY",
            "TELEGRAM_BOT_TOKEN", "TELEGRAM_CHAT_ID", "ANTHROPIC_API_KEY"]
missing = [v for v in required if not os.environ.get(v)]
if missing:
    msg = f"Weekly-review FAILED: missing env vars: {', '.join(missing)}"
    telegram_alert("CRITICAL", msg)
    sys.exit(1)

# ------------------------------------------------------------
# Gather data
# ------------------------------------------------------------

print(f"[{DATE}] Weekly review starting...")

account = jsonable(bash("bash scripts/alpaca.sh account"), {})
positions = jsonable(bash("bash scripts/alpaca.sh positions"), [])
spy_quote = jsonable(bash("bash scripts/finnhub.sh quote SPY"), {})

equity = float(account.get("equity", 0))

# Resolver capital operativo: límite manual (si existe) o equity real de Alpaca
OPERATING_CAPITAL = OPERATING_CAPITAL_ENV if OPERATING_CAPITAL_ENV > 0 else int(equity) if equity > 0 else 100000
operating_equity = min(OPERATING_CAPITAL, equity)

# Read memory
strategy = read_memory("TRADING-STRATEGY.md")
trade_log = read_memory("TRADE-LOG.md")
research_log = read_memory("RESEARCH-LOG.md")
weekly_review = read_memory("WEEKLY-REVIEW.md")
equity_history_raw = read_memory(".equity-history.jsonl")

# Parse equity history to find Monday start
equity_history = []
for line in equity_history_raw.strip().split("\n"):
    if not line:
        continue
    try:
        equity_history.append(json.loads(line))
    except:
        pass

monday_equity = operating_equity  # default: si no hay historia, usar equity actual
for entry in equity_history:
    try:
        d = datetime.date.fromisoformat(entry["date"])
        if d == MONDAY or (d < MONDAY and (MONDAY - d).days <= 3):  # Friday before
            monday_equity = entry.get("operating_equity", operating_equity)
            break
    except:
        pass

week_pnl = operating_equity - monday_equity
week_pnl_pct = (week_pnl / monday_equity * 100) if monday_equity > 0 else 0

# Extract this week's trade entries (rough — by date prefix)
week_trades = []
for m in re.finditer(r"### (\d{4}-\d{2}-\d{2})(.*?)(?=\n### \d{4}-\d{2}-\d{2}|\Z)", trade_log, re.DOTALL):
    try:
        d = datetime.date.fromisoformat(m.group(1))
        if MONDAY <= d <= TODAY:
            week_trades.append(m.group(0))
    except:
        pass

week_trades_text = "\n".join(week_trades)[-6000:]  # cap size

# ------------------------------------------------------------
# Build prompt
# ------------------------------------------------------------

system_msg = """You are an autonomous paper trading bot performing a Friday end-of-week review.
You analyze the week's performance, identify patterns, and propose careful strategy adjustments.
Strict rule: do NOT propose strategy changes based on 1 week of data (it's noise).
A rule must FAIL for 2+ consecutive weeks before relaxing it.
A rule must PROVE OUT for 2+ consecutive weeks before tightening it."""

user_prompt = f"""Today is Friday {DATE}. Week ended {TODAY.isoformat()}.

STRATEGY (current rules):
```
{strategy[:2000]}
```

THIS WEEK'S TRADE ENTRIES:
```
{week_trades_text}
```

ACCOUNT STATE END OF WEEK:
- Operating equity: ${operating_equity:.2f}
- Alpaca equity: ${equity:.2f}
- Monday starting equity: ${monday_equity:.2f}
- Week P&L: ${week_pnl:.2f} ({week_pnl_pct:.2f}%)
- Open positions: {len(positions)}

OPEN POSITIONS AT WEEK END:
{json.dumps(positions, indent=2)[:1500]}

PREVIOUS WEEKLY REVIEWS (recent):
```
{weekly_review[-2500:]}
```

YOUR TASK:
1. Use web_search to get S&P 500 weekly performance for the week ending {DATE}.
2. Compute and analyze:
   - Closed trades W/L/open counts
   - Win rate (closed trades only)
   - Best trade, worst trade
   - Profit factor (sum winners / |sum losers|)
   - Bot vs S&P 500 weekly performance
   - Sectors that worked vs failed
3. Output the complete WEEKLY-REVIEW entry below (exact format, nothing extra):

## Week ending {DATE}

### Stats
| Metric | Value |
|--------|-------|
| Starting portfolio (Mon) | ${monday_equity:.2f} |
| Ending portfolio (Fri) | ${operating_equity:.2f} |
| Week return | ${week_pnl:.2f} ({week_pnl_pct:+.2f}%) |
| S&P 500 week | [from web_search] |
| Bot vs S&P | [delta] |
| Trades total | [N (W:X / L:Y / open:Z)] |
| Win rate | [X%] |
| Best trade | [SYM +X%] |
| Worst trade | [SYM -X%] |
| Profit factor | [X.XX] |

### Closed Trades This Week
| Ticker | Entry | Exit | P&L $ | P&L % | Sector | Notes |
|--------|-------|------|-------|-------|--------|-------|
| [parse from week trades] |

### Open Positions at Week End
| Ticker | Entry | Friday Close | Unrealized | Stop | Sector |
|--------|-------|--------------|------------|------|--------|

### What Worked (3-5 bullets)
- ...

### What Didn't Work (3-5 bullets)
- ...

### Sector Performance
- [sector breakdown]

### Key Lessons
- ...

### Adjustments for Next Week
- [Only propose if rule failed 2+ weeks OR proved out 2+ weeks. Otherwise: "No changes — insufficient data"]

### Overall Grade: [A-F]
Reasoning: [one paragraph]

Output ONLY the markdown above, nothing else.
"""

# ------------------------------------------------------------
# Call API
# ------------------------------------------------------------

import anthropic
client = anthropic.Anthropic()

print("Calling Anthropic API (weekly-review, claude-sonnet-4-6)...")

try:
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=3500,
        system=system_msg,
        tools=[{"type": "web_search_20250305", "name": "web_search", "max_uses": 3}],
        messages=[{"role": "user", "content": user_prompt}]
    )
except Exception as e:
    msg = f"Weekly-review API call failed: {e}"
    telegram_alert("CRITICAL", msg)
    sys.exit(1)

output_text = ""
for block in response.content:
    if getattr(block, "type", "") == "text":
        output_text += block.text

if not output_text.strip():
    telegram_alert("WARNING", "Weekly-review: empty AI response.")
    sys.exit(1)

# ------------------------------------------------------------
# Append to WEEKLY-REVIEW.md
# ------------------------------------------------------------

wr = ROOT / "memory" / "WEEKLY-REVIEW.md"
existing = wr.read_text() if wr.exists() else "# Weekly Review\n\nFriday reviews appended here.\n"
with wr.open("w") as f:
    f.write(existing.rstrip() + "\n\n" + output_text.strip() + "\n")

print(f"[{DATE}] WEEKLY-REVIEW updated.")

# ------------------------------------------------------------
# Telegram summary (always)
# ------------------------------------------------------------

# Extract grade if possible
grade_match = re.search(r"Overall Grade:\s*([A-F])", output_text)
grade = grade_match.group(1) if grade_match else "?"

# Try to extract S&P comparison
sp_match = re.search(r"S&P 500 week\s*\|\s*([+\-]?\d+\.?\d*%?)", output_text)
sp_perf = sp_match.group(1) if sp_match else "?"

msg = f"""📊 Week ending {DATE}

Operating: ${operating_equity:.2f}
Week: ${week_pnl:+.2f} ({week_pnl_pct:+.2f}%)
vs S&P: {sp_perf}
Trades: {len(week_trades)} esta semana

Grade: {grade}

Ver detalle completo en memory/WEEKLY-REVIEW.md"""

telegram_send(msg)
print("Done.")
