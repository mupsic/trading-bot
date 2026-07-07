#!/usr/bin/env bash

# ============================================
# DAILY SUMMARY EOD (bash puro, sin Claude)
# ============================================
# Calcula P&L del día sobre el equity real de la cuenta Alpaca
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
# OPERATING_CAPITAL se fija dinámicamente tras leer el equity real

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
# NOTA: se ha quitado 2>/dev/null para que si Alpaca responde con error o
# datos raros, la respuesta aparezca en los logs de GitHub Actions.
# Además, se imprime la respuesta cruda antes de parsear para debug.
ACCOUNT=$(bash "$SCRIPTS/alpaca.sh" account)
echo "[debug] ACCOUNT response: $ACCOUNT" >&2
# Defensive: try/catch para que un null en cualquier campo devuelva 0
# en lugar de matar el script con exit 5.
EQUITY=$(echo "$ACCOUNT" | jq -r 'try (.equity | tonumber) catch 0')
CASH=$(echo "$ACCOUNT" | jq -r 'try (.cash | tonumber) catch 0')
DAYTRADE_COUNT=$(echo "$ACCOUNT" | jq -r 'try (.daytrade_count | tonumber) catch 0')

POSITIONS=$(bash "$SCRIPTS/alpaca.sh" positions)
echo "[debug] POSITIONS response: $POSITIONS" >&2
POS_COUNT=$(echo "$POSITIONS" | jq 'length')
POS_VALUE=$(echo "$POSITIONS" | jq '[.[] | try (.market_value | tonumber) catch 0] | add // 0')

# ============================================
# Compute operating-equity metrics
# ============================================
# Usar equity real como capital operativo si no hay límite manual en .env
if [[ -z "${OPERATING_CAPITAL:-}" ]]; then
  OPERATING_CAPITAL=$(python3 -c "print(round($EQUITY, 2))")
fi

OPERATING_EQUITY=$(python3 -c "print(round(min($OPERATING_CAPITAL, $EQUITY), 2))")
DEPLOYED_PCT=$(python3 -c "print(round($POS_VALUE / $OPERATING_CAPITAL * 100, 1))")

# Yesterday's equity y primer registro (para Total P&L desde inicio)
YESTERDAY_EQUITY=$OPERATING_EQUITY
PEAK_EQUITY=$OPERATING_EQUITY
FIRST_EQUITY=$OPERATING_EQUITY

if [[ -f "$EQUITY_HISTORY" ]]; then
  read -r YESTERDAY_EQUITY PEAK_EQUITY FIRST_EQUITY < <(python3 <<PYEOF
import json
entries = []
try:
    with open("$EQUITY_HISTORY") as f:
        for line in f:
            try:
                d = json.loads(line.strip())
                if d:
                    entries.append(d)
            except:
                pass
except FileNotFoundError:
    pass

if entries:
    last_eq = entries[-1].get("operating_equity", $OPERATING_EQUITY)
    peak = max($OPERATING_EQUITY, *(d.get("operating_equity", 0) for d in entries),
                                  *(d.get("peak_equity", 0) for d in entries))
    first_eq = entries[0].get("operating_equity", $OPERATING_EQUITY)
else:
    last_eq = $OPERATING_EQUITY
    peak = $OPERATING_EQUITY
    first_eq = $OPERATING_EQUITY
print(last_eq, peak, first_eq)
PYEOF
)
fi

DAY_PNL=$(python3 -c "print(round($OPERATING_EQUITY - $YESTERDAY_EQUITY, 2))")
DAY_PNL_PCT=$(python3 -c "print(round(($OPERATING_EQUITY - $YESTERDAY_EQUITY) / $YESTERDAY_EQUITY * 100, 2)) if $YESTERDAY_EQUITY > 0 else print(0)")
# Total P&L desde el primer día registrado (en lugar de vs. cap fijo $3000)
PHASE_PNL=$(python3 -c "print(round($OPERATING_EQUITY - $FIRST_EQUITY, 2))")
PHASE_PNL_PCT=$(python3 -c "print(round(($OPERATING_EQUITY - $FIRST_EQUITY) / $FIRST_EQUITY * 100, 2)) if $FIRST_EQUITY > 0 else print(0)")

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
  echo "- **Operating equity**: \$$OPERATING_EQUITY"
  echo "- **Cash**: \$$CASH"
  echo "- **Positions value**: \$$POS_VALUE ($DEPLOYED_PCT% deployed)"
  echo "- **Day P&L**: \$$DAY_PNL ($DAY_PNL_PCT%)"
  echo "- **Total P&L (desde inicio)**: \$$PHASE_PNL ($PHASE_PNL_PCT%)"
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
    echo "$POSITIONS" | jq -r '.[] | "| \(.symbol) | \(.qty) | \(.avg_entry_price)$ | \(.current_price)$ | \(.unrealized_pl)$ (\((try (.unrealized_plpc | tonumber) catch 0) * 100 | (. * 10 | round) / 10)%) | \((try (.change_today | tonumber) catch 0) * 100 | (. * 10 | round) / 10)% |"'
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
${PNL_EMOJI} Total (inicio): \$$PHASE_PNL ($PHASE_PNL_PCT%)
Cash: \$$CASH | Deployed: $DEPLOYED_PCT%
Peak: \$$NEW_PEAK | Drawdown: ${DRAWDOWN_PCT}%
Trades today: $TRADES_TODAY | Semana: $TRADES_THIS_WEEK/3"

if [[ "$POS_COUNT" -gt 0 ]]; then
  MSG+="

Posiciones:"
  POSITIONS_TXT=$(echo "$POSITIONS" | jq -r '.[] | "  \(.symbol): \(.qty) sh, P&L \((try (.unrealized_plpc | tonumber) catch 0) * 100 | (. * 10 | round) / 10)%"')
  MSG+="
$POSITIONS_TXT"
fi

notify "$MSG"

log "EOD snapshot complete. Operating=\$$OPERATING_EQUITY | Day=\$$DAY_PNL"
exit 0
