#!/usr/bin/env python3
"""
Pre-market AI routine — versión Anthropic API (para GitHub Actions).

Gathering pattern: bash wrappers ingieren datos → todo se pasa en UN solo
prompt a Anthropic API con tool web_search habilitado → respuesta se
parsea y se escribe a memory/RESEARCH-LOG.md con bloque JSON parseable
que market-open.sh leerá después.
"""

import os
import sys
import json
import subprocess
import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATE = datetime.date.today().isoformat()
OPERATING_CAPITAL = int(os.environ.get("OPERATING_CAPITAL", "3000"))

# ============================================================
# Helpers
# ============================================================

def bash(cmd):
    """Run a bash command (string), return stdout. Tolerant of errors."""
    try:
        out = subprocess.run(
            cmd, shell=True, capture_output=True, text=True, cwd=ROOT, timeout=30
        )
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
    subprocess.run(
        ["bash", str(ROOT / "scripts/telegram.sh"), "send", msg],
        cwd=ROOT, capture_output=True
    )

def telegram_alert(level, msg):
    subprocess.run(
        ["bash", str(ROOT / "scripts/telegram.sh"), "alert", level, msg],
        cwd=ROOT, capture_output=True
    )

def read_memory(name):
    p = ROOT / "memory" / name
    return p.read_text() if p.exists() else ""

# ============================================================
# Verify required env vars
# ============================================================

required = ["ALPACA_API_KEY", "ALPACA_API_SECRET", "FINNHUB_API_KEY",
            "TELEGRAM_BOT_TOKEN", "TELEGRAM_CHAT_ID", "ANTHROPIC_API_KEY"]
missing = [v for v in required if not os.environ.get(v)]
if missing:
    msg = f"Pre-market FAILED: missing env vars: {', '.join(missing)}"
    print(msg, file=sys.stderr)
    telegram_alert("CRITICAL", msg)
    sys.exit(1)

# ============================================================
# Check BOT-STATE for PAUSE
# ============================================================

bot_state = read_memory("BOT-STATE.md")
PAUSED = "PAUSED: yes" in bot_state

# ============================================================
# Gather data from Alpaca + Finnhub
# ============================================================

print(f"[{DATE}] Gathering data...")

account = jsonable(bash("bash scripts/alpaca.sh account"), {})
positions = jsonable(bash("bash scripts/alpaca.sh positions"), [])
orders = jsonable(bash("bash scripts/alpaca.sh orders"), [])

spy_quote = jsonable(bash("bash scripts/finnhub.sh quote SPY"), {})
qqq_quote = jsonable(bash("bash scripts/finnhub.sh quote QQQ"), {})
market_news = jsonable(bash("bash scripts/finnhub.sh news"), [])
earnings = jsonable(bash("bash scripts/finnhub.sh earnings"), {})
economic = jsonable(bash("bash scripts/finnhub.sh economic"), {})

equity = float(account.get("equity", 0))
cash = float(account.get("cash", 0))
daytrade_count = int(float(account.get("daytrade_count", 0)))
positions_value = sum(float(p.get("market_value", 0)) for p in positions)
capital_available = max(0.0, OPERATING_CAPITAL - positions_value)

# Trim news to last 10 to keep prompt size sane
market_news_trim = market_news[:10] if isinstance(market_news, list) else []

# Memory context (trim long files)
context = read_memory("PROJECT-CONTEXT.md")
strategy = read_memory("TRADING-STRATEGY.md")
recent_trades = read_memory("TRADE-LOG.md")[-3000:]
recent_research = read_memory("RESEARCH-LOG.md")[-2000:]

# ============================================================
# Build the prompt
# ============================================================

system_msg = """You are an autonomous paper trading bot for the NY market.
You operate on Alpaca paper trading with a HARD CAP of $3,000 operating capital.
NEVER touch options, crypto, futures, leverage, or margin. Stocks only.
Be concise, no fluff. Output exactly the requested format."""

user_prompt = f"""DATE: {DATE}

CONTEXT (read-only, immutable rules):
```
{context[:1500]}
```

STRATEGY (read-only):
```
{strategy[:1500]}
```

BOT STATE:
- Paused: {"YES — decision MUST be HOLD regardless of candidates" if PAUSED else "no (active)"}
- Operating cap: $3,000
- Alpaca equity: ${equity:.2f}
- Cash: ${cash:.2f}
- Positions value: ${positions_value:.2f}
- Capital available within cap: ${capital_available:.2f}
- Daytrade count: {daytrade_count}/3
- Open positions: {len(positions)}/5

OPEN POSITIONS:
{json.dumps(positions, indent=2)[:1500]}

RECENT TRADE LOG (last):
```
{recent_trades}
```

LIVE FINNHUB DATA:
- SPY quote: {json.dumps(spy_quote)}
- QQQ quote: {json.dumps(qqq_quote)}
- Market news (top 5 headlines): {json.dumps([n.get('headline','') for n in market_news_trim[:5]] if isinstance(market_news_trim, list) else [])}
- Earnings calendar (raw): {json.dumps(earnings)[:1000]}

YOUR TASK:
Use the web_search tool to gather:
1. Current SPY 200-day moving average (specific number)
2. Current VIX index level (specific number)
3. Today's top 3-5 stock market catalysts
4. Sector momentum: which sector ETF is strongest this week (XLK, XLF, XLV, XLE, XLY, XLP)
5. Pre-market movers with high volume

Apply market regime gate:
- If SPY > MA200 AND VIX < 25 → REGIME = ON
- Otherwise → REGIME = OFF (no new trades today)

If REGIME = ON, identify 2-3 stock candidates that pass ALL these filters:
- Market cap > $1B
- Has a specific named catalyst (earnings beat, FDA, M&A, breakout, etc.)
- Sector showing positive momentum
- No earnings reporting within next 7 days (avoid event risk)
- shares × entry_price ≤ $600 (20% of cap)
- (positions_value + new_buy_cost) ≤ $3,000

Output the complete RESEARCH-LOG entry in this EXACT format (no extra text before or after):

## {DATE} — Pre-market Research

### Account Snapshot
- Alpaca equity: ${equity:.2f}
- Operating cap: $3,000
- Cash: ${cash:.2f}
- Positions value: ${positions_value:.2f}
- Capital available: ${capital_available:.2f}
- Daytrade count: {daytrade_count}/3
- Bot state: {"PAUSED" if PAUSED else "ACTIVE"}

### Market Regime
- SPY: $X (MA200: $X) — [ABOVE/BELOW]
- VIX: X — [LOW/HIGH]
- Regime: [ON / OFF]
- Reason: [one line]

### Market Context
- Top catalysts today: [bulleted list]
- Sector leaders: [list with %]
- Economic events: [list]

### Trade Candidates (only if Regime ON)
1. TICKER — catalyst, entry $X, stop $X (-7%), target $X (+14%), shares=N, R:R 1:2
2. ...

### Risk Factors Today
- ...

### Decision
TRADE [list candidates] OR HOLD (default if Regime OFF, bot paused, or no edge)

### CANDIDATES (machine-readable)
```json
{{
  "date": "{DATE}",
  "regime": "ON" or "OFF",
  "decision": "TRADE" or "HOLD",
  "candidates": [
    {{
      "symbol": "AAPL",
      "entry_price": 150.00,
      "stop_pct": 7,
      "trailing_stop_pct": 10,
      "shares": 4,
      "position_cost": 600.00,
      "target_price": 171.00,
      "catalyst": "Specific catalyst description",
      "sector": "Technology",
      "rr_ratio": "1:2"
    }}
  ]
}}
```

CRITICAL RULES:
- shares × entry_price MUST be ≤ 600
- If bot is PAUSED or regime OFF → candidates: []
- Each candidate MUST have a real, specific catalyst (not generic "looks bullish")
- Output ONLY the markdown above, nothing else
"""

# ============================================================
# Call Anthropic API with web_search tool
# ============================================================

import anthropic

client = anthropic.Anthropic()

print("Calling Anthropic API (claude-opus-4-6 with web_search)...")

try:
    response = client.messages.create(
        model="claude-opus-4-6",
        max_tokens=4096,
        system=system_msg,
        tools=[{
            "type": "web_search_20250305",
            "name": "web_search",
            "max_uses": 8
        }],
        messages=[{"role": "user", "content": user_prompt}]
    )
except Exception as e:
    msg = f"Pre-market API call failed: {e}"
    print(msg, file=sys.stderr)
    telegram_alert("CRITICAL", msg)
    sys.exit(1)

# Extract text from response
output_text = ""
for block in response.content:
    if getattr(block, "type", "") == "text":
        output_text += block.text

if not output_text.strip():
    telegram_alert("WARNING", "Pre-market: empty AI response. No RESEARCH-LOG written.")
    sys.exit(1)

# ============================================================
# Append to RESEARCH-LOG.md
# ============================================================

research_log = ROOT / "memory" / "RESEARCH-LOG.md"
existing = research_log.read_text() if research_log.exists() else ""
with research_log.open("w") as f:
    f.write(existing.rstrip() + "\n\n" + output_text.strip() + "\n")

print(f"[{DATE}] RESEARCH-LOG updated.")

# ============================================================
# Telegram notification (only if urgent)
# ============================================================

import re

# Try to parse decision and regime for alerting
upper = output_text.upper()
regime_off = "REGIME: OFF" in upper or '"regime": "OFF"' in output_text
held_in_red = any(float(p.get("unrealized_plpc", 0)) <= -0.05 for p in positions)

if PAUSED:
    telegram_send(f"📋 Pre-market {DATE}: bot pausado, decisión HOLD.")
elif regime_off:
    telegram_send(f"📊 Pre-market {DATE}: Regime OFF (SPY o VIX desfavorable). HOLD hoy.")
elif held_in_red:
    telegram_alert("WARNING", f"📊 Pre-market {DATE}: hay posición con P&L ≤ -5%. Revisa research log.")
else:
    # Try to extract candidates count
    try:
        json_block = re.search(r"```json\s*(\{.*?\})\s*```", output_text, re.DOTALL)
        if json_block:
            data = json.loads(json_block.group(1))
            n = len(data.get("candidates", []))
            if n > 0:
                telegram_send(f"📊 Pre-market {DATE}: {n} candidatos identificados. Market-open ejecutará en ~2h.")
            else:
                telegram_send(f"📋 Pre-market {DATE}: sin candidatos válidos hoy. HOLD.")
    except Exception:
        pass  # silent if can't parse

print("Done.")
