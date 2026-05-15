#!/usr/bin/env bash

# ============================================
# DAILY SUMMARY EOD (bash puro, sin Claude)
# ============================================
# Calcula P&L del día sobre operating equity (capped a $3000)
# Append EOD snapshot a TRADE-LOG
# Mantiene .equity-history.jsonl con peak/equity por día
# Telegram resumen siempre
# ============================================

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ENV_FILE="$ROOT/.env"
if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

: "${ALPACA_API_KEY:?ALPACA_API_KEY missing}"
: "${ALPACA_API_SECRET:?ALPACA_API_SECRET missing}"
: "${TELEGRAM_BOT_TOKEN:?TELEGRAM_BOT_TOKEN missing}"
: "${TELEGRAM_CHAT_ID:?TELEGRAM_CHAT_ID missing}"
: "${OPERATING_CAPITAL:=3000}"

SCRIPTS="$ROOT/scripts"
MEMORY="$ROOT/memory"
TRADE_LOG="$MEMORY/TRADE-LOG.md"
EQUITY_HISTORY="$MEMORY/.equity-history.jsonl"

DATE=$(date '+%Y-%m-%d')
TS=$(date '+%Y-%m-%d %H:%M:%S')

log() { echo "[$(date '+%H:%M:%S')] $*"; }
notify() { bash "$SCRIPTS/telegram.sh" send "$1" > /dev/null 2>&1 || true; }

# ============================================
# Pull state
# ============================================
ACCOUNT=$(bash "$SCRIPTS/alpaca.sh" account 2>/dev/null)
EQUITY=$(echo "$ACCOUNT" | jq -r '.equity | tonumber')
CASH=$(echo "$ACCOUNT" | jq -r '.cash | tonumber')
DAYTRADE_COUNT=$(echo "$ACCOUNT" | jq -r '.daytrade_count | tonumber')

POSITIONS=$(bash "$SCRIPTS/alpaca.sh" positions 2>/dev/null)
POS_COUNT=$(echo "$POSITIONS" | jq 'length')
POS_VALUE=$(echo "$POSITIONS" | jq '[.[].market_value | tonumber] | add // 0')

# ============================================
# Compute operating-equity metrics
# ============================================
OPERATING_EQUITY=$(python3 -c "print(round(min($OPERATING_CAPITAL, $EQUITY), 2))")
DEPLOYED_PCT=$(python3 -c "print(round($POS_VALUE / $OPERATING_CAPITAL * 100, 1))")

# Yesterday's equity from history
YESTERDAY_EQUITY=$OPERATING_CAPITAL
PEAK_EQUITY=$OPERATING_EQUITY

if [[ -f "$EQUITY_HISTORY" ]]; then
  read -r YESTERDAY_EQUITY PEAK_EQUITY < <(python3 <<PYEOF
import json
last_eq = $OPERATING_CAPITAL
peak = $OPERATING_EQUITY
try:
    with open("$EQUITY_HISTORY") as f:
        for line in f:
            try:
                d = json.loads(line.strip())
                last_eq = d.get("operating_equity", last_eq)
                peak = max(peak, d.get("operating_equity", 0), d.get("peak_equity", 0))
            except:
                pass
except FileNotFoundError:
    pass
print(last_eq, peak)
PYEOF
)
fi

DAY_PNL=$(python3 -c "print(round($OPERATING_EQUITY - $YESTERDAY_EQUITY, 2))")
DAY_PNL_PCT=$(python3 -c "print(round(($OPERATING_EQUITY - $YESTERDAY_EQUITY) / $YESTERDAY_EQUITY * 100, 2)) if $YESTERDAY_EQUITY > 0 else print(0)")
PHASE_PNL=$(python3 -c "print(round($OPERATING_EQUITY - $OPERATING_CAPITAL, 2))")
PHASE_PNL_PCT=$(python3 -c "print(round(($OPERATING_EQUITY - $OPERATING_CAPITAL) / $OPERATING_CAPITAL * 100, 2))")

# Update peak
NEW_PEAK=$(python3 -c "print(round(max($PEAK_EQUITY, $OPERATING_EQUITY), 2))")
DRAWDOWN_PCT=$(python3 -c "print(round(($NEW_PEAK - $OPERATING_EQUITY) / $NEW_PEAK * 100, 2)) if $NEW_PEAK > 0 else print(0)")

# Count trades today and this week
TRADES_TODAY=$(grep -c "^### $DATE.*Trade Entry" "$TRADE_LOG" 2>/dev/null || echo "0")
TRADES_THIS_WEEK=$(python3 <<PYEOF
import re
from datetime import datetime, timedelta
today = datetime.strptime("$DATE", "%Y-%m-%d")
monday = today - timedelta(days=today.weekday())
try:
    with open("$TRADE_LOG") as f:
        text = f.read()
except FileNotFoundError:
    print(0)
    exit(0)
count = 0
for m in re.finditer(r'### (\d{4}-\d{2}-\d{2}).*?Trade Entry', text):
    d = datetime.strptime(m.group(1), "%Y-%m-%d")
    if d >= monday and d <= today:
        count += 1
print(count)
PYEOF
)

# ============================================
# Append EOD snapshot to TRADE-LOG
# ============================================
{
  echo ""
  echo "### $DATE — EOD Snapshot"
  echo "- **Alpaca equity (reported)**: \$$EQUITY"
  echo "- **Operating equity (capped)**: \$$OPERATING_EQUITY"
  echo "- **Cash**: \$$CASH"
  echo "- **Positions value**: \$$POS_VALUE ($DEPLOYED_PCT% deployed)"
  echo "- **Day P&L**: \$$DAY_PNL ($DAY_PNL_PCT%)"
  echo "- **Phase P&L**: \$$PHASE_PNL ($PHASE_PNL_PCT%)"
  echo "- **Peak equity**: \$$NEW_PEAK"
  echo "- **Drawdown from peak**: ${DRAWDOWN_PCT}%"
  echo "- **Trades today**: $TRADES_TODAY"
  echo "- **Trades this week**: $TRADES_THIS_WEEK / 3"
  echo "- **Daytrade count**: $DAYTRADE_COUNT / 3"

  if [[ "$POS_COUNT" -gt 0 ]]; then
    echo ""
    echo "**Open positions:**"
    echo ""
    echo "| Ticker | Shares | Entry | Current | Unrealized P&L | Day Chg |"
    echo "|--------|--------|-------|---------|-----------------|---------|"
    echo "$POSITIONS" | jq -r '.[] | "| \(.symbol) | \(.qty) | \(.avg_entry_price)$ | \(.current_price)$ | \(.unrealized_pl)$ (\(.unrealized_plpc | tonumber * 100 | (. * 10 | round) / 10)%) | \(.change_today | tonumber * 100 | (. * 10 | round) / 10)% |"'
  fi
} >> "$TRADE_LOG"

# ============================================
# Append to equity history (machine-readable)
# ============================================
HISTORY_ENTRY=$(python3 -c "import json; print(json.dumps({'date':'$DATE','operating_equity':$OPERATING_EQUITY,'alpaca_equity':$EQUITY,'peak_equity':$NEW_PEAK,'day_pnl':$DAY_PNL,'positions_count':$POS_COUNT}))")
echo "$HISTORY_ENTRY" >> "$EQUITY_HISTORY"

# ============================================
# Telegram summary (always)
# ============================================
MSG="📈 EOD $DATE

Operating: \$$OPERATING_EQUITY"

# P&L emoji
PNL_EMOJI="📊"
NEG_DAY=$(python3 -c "print(1 if $DAY_PNL < 0 else 0)")
if [[ "$NEG_DAY" == "1" ]]; then PNL_EMOJI="📉"; fi
POS_DAY=$(python3 -c "print(1 if $DAY_PNL > 0 else 0)")
if [[ "$POS_DAY" == "1" ]]; then PNL_EMOJI="📈"; fi

MSG+="
${PNL_EMOJI} Day: \$$DAY_PNL ($DAY_PNL_PCT%)
${PNL_EMOJI} Phase: \$$PHASE_PNL ($PHASE_PNL_PCT%)
Cash: \$$CASH | Deployed: $DEPLOYED_PCT%
Peak: \$$NEW_PEAK | Drawdown: ${DRAWDOWN_PCT}%
Trades today: $TRADES_TODAY | Semana: $TRADES_THIS_WEEK/3"

if [[ "$POS_COUNT" -gt 0 ]]; then
  MSG+="

Posiciones:"
  POSITIONS_TXT=$(echo "$POSITIONS" | jq -r '.[] | "  \(.symbol): \(.qty) sh, P&L \(.unrealized_plpc | tonumber * 100 | (. * 10 | round) / 10)%"')
  MSG+="
$POSITIONS_TXT"
fi

notify "$MSG"

log "EOD snapshot complete. Operating=\$$OPERATING_EQUITY | Day=\$$DAY_PNL"
exit 0
