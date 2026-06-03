#!/usr/bin/env bash

# ============================================
# MARKET-OPEN EXECUTION (bash puro, sin Claude)
# ============================================
# Lee bloque JSON de candidatos de memory/RESEARCH-LOG.md (escrito por pre-market)
# Aplica buy-side gate completo. Ejecuta market buys.
# Coloca trailing stops 10% GTC inmediatamente tras cada fill.
# Usa equity real de Alpaca como capital operativo (sin cap artificial).
# GATE 5 (cash) impide endeudarse: nunca compra más de lo que hay en caja.
# Respeta BOT-STATE.md PAUSED.
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

# Required
: "${ALPACA_API_KEY:?ALPACA_API_KEY missing}"
: "${ALPACA_API_SECRET:?ALPACA_API_SECRET missing}"
: "${TELEGRAM_BOT_TOKEN:?TELEGRAM_BOT_TOKEN missing}"
: "${TELEGRAM_CHAT_ID:?TELEGRAM_CHAT_ID missing}"
# OPERATING_CAPITAL se fija dinámicamente tras leer el equity real (ver STEP 3)

SCRIPTS="$ROOT/scripts"
MEMORY="$ROOT/memory"
RESEARCH_LOG="$MEMORY/RESEARCH-LOG.md"
TRADE_LOG="$MEMORY/TRADE-LOG.md"
BOT_STATE="$MEMORY/BOT-STATE.md"

DATE=$(date '+%Y-%m-%d')
TS=$(date '+%Y-%m-%d %H:%M:%S')

log() { echo "[$(date '+%H:%M:%S')] $*"; }
notify() { bash "$SCRIPTS/telegram.sh" send "$1" > /dev/null 2>&1 || true; }
alert() { bash "$SCRIPTS/telegram.sh" alert "WARNING" "$1" > /dev/null 2>&1 || true; }

# ============================================
# STEP 1 — Check BOT-STATE pause flag
# ============================================
if [[ -f "$BOT_STATE" ]] && grep -q "^PAUSED: yes" "$BOT_STATE"; then
  log "Bot is PAUSED. Skipping market-open."
  notify "⏸ Market-open SKIPPED: bot pausado (/resume para reactivar)"
  exit 0
fi

# ============================================
# STEP 2 — Extract today's candidates JSON from RESEARCH-LOG
# ============================================
if [[ ! -f "$RESEARCH_LOG" ]]; then
  log "ERROR: RESEARCH-LOG.md not found"
  alert "Market-open: no RESEARCH-LOG.md found. Did pre-market run?"
  exit 1
fi

# Find today's entry and extract its ```json``` block under CANDIDATES (machine-readable)
CANDIDATES_JSON=$(python3 <<PYEOF
import re, sys, json
with open("$RESEARCH_LOG") as f:
    text = f.read()
# Find today's section
m = re.search(r'## ' + re.escape("$DATE") + r'.*?(?=\n## \d{4}-\d{2}-\d{2}|\Z)', text, re.DOTALL)
if not m:
    print('{"error":"no_entry_today"}')
    sys.exit(0)
section = m.group(0)
# Find json block after CANDIDATES (machine-readable)
m2 = re.search(r'CANDIDATES \(machine-readable\).*?\`\`\`json\s*(.*?)\s*\`\`\`', section, re.DOTALL)
if not m2:
    print('{"error":"no_json_block"}')
    sys.exit(0)
try:
    data = json.loads(m2.group(1))
    print(json.dumps(data))
except Exception as e:
    print(json.dumps({"error":"parse_failed","detail":str(e)}))
PYEOF
)

ERROR=$(echo "$CANDIDATES_JSON" | jq -r '.error // empty')
if [[ -n "$ERROR" ]]; then
  log "Cannot extract candidates: $ERROR"
  notify "📊 Market-open: no se ejecutarán trades hoy. Razón: $ERROR"
  exit 0
fi

REGIME=$(echo "$CANDIDATES_JSON" | jq -r '.regime')
DECISION=$(echo "$CANDIDATES_JSON" | jq -r '.decision')
NUM_CANDIDATES=$(echo "$CANDIDATES_JSON" | jq '.candidates | length')

log "Regime=$REGIME | Decision=$DECISION | Candidates=$NUM_CANDIDATES"

if [[ "$REGIME" != "ON" || "$DECISION" != "TRADE" || "$NUM_CANDIDATES" -eq 0 ]]; then
  notify "📊 Market-open: HOLD (regime=$REGIME, $NUM_CANDIDATES candidatos). No trades hoy."
  exit 0
fi

# ============================================
# STEP 3 — Pull live state
# ============================================
ACCOUNT=$(bash "$SCRIPTS/alpaca.sh" account 2>/dev/null)
EQUITY=$(echo "$ACCOUNT" | jq -r '.equity | tonumber')
CASH=$(echo "$ACCOUNT" | jq -r '.cash | tonumber')
DAYTRADE_COUNT=$(echo "$ACCOUNT" | jq -r '.daytrade_count | tonumber')

POSITIONS=$(bash "$SCRIPTS/alpaca.sh" positions 2>/dev/null)
POS_COUNT=$(echo "$POSITIONS" | jq 'length')
POS_VALUE=$(echo "$POSITIONS" | jq '[.[].market_value | tonumber] | add // 0')

# Usar equity real como capital operativo si no hay límite manual en .env
if [[ -z "${OPERATING_CAPITAL:-}" ]]; then
  OPERATING_CAPITAL=$(python3 -c "print(round($EQUITY, 2))")
fi

# Capital tracking: cuánto capital queda disponible dentro del límite operativo
CAPITAL_USED=$POS_VALUE
CAPITAL_AVAILABLE=$(python3 -c "print(round($OPERATING_CAPITAL - $CAPITAL_USED, 2))")

# Límite por posición: 20% del capital operativo (dinámico)
MAX_POS_SIZE=$(python3 -c "print(round($OPERATING_CAPITAL * 0.20, 2))")

log "Alpaca equity=\$$EQUITY | Cash=\$$CASH | Positions=$POS_COUNT (\$$POS_VALUE)"
log "Operating cap=\$$OPERATING_CAPITAL | Used=\$$CAPITAL_USED | Available=\$$CAPITAL_AVAILABLE | Max/pos=\$$MAX_POS_SIZE"

# Count trades this week (Mon-today)
TRADES_THIS_WEEK=$(python3 <<PYEOF
import re
from datetime import datetime, timedelta
today = datetime.strptime("$DATE", "%Y-%m-%d")
# Monday of this week
monday = today - timedelta(days=today.weekday())
try:
    with open("$TRADE_LOG") as f:
        text = f.read()
except FileNotFoundError:
    print(0)
    exit(0)
# Count "Trade Entry" sections in this week's range
count = 0
for m in re.finditer(r'### (\d{4}-\d{2}-\d{2}).*?Trade Entry', text):
    d = datetime.strptime(m.group(1), "%Y-%m-%d")
    if d >= monday and d <= today:
        count += 1
print(count)
PYEOF
)

log "Trades this week: $TRADES_THIS_WEEK/3"

# ============================================
# STEP 4 — Iterate candidates, apply buy-gate, execute
# ============================================
TRADES_EXECUTED=0
TRADES_SKIPPED=0
EXECUTED_LIST=""
SKIPPED_LIST=""

NUM=$(echo "$CANDIDATES_JSON" | jq '.candidates | length')

for i in $(seq 0 $((NUM - 1))); do
  candidate=$(echo "$CANDIDATES_JSON" | jq -c ".candidates[$i]")
  SYMBOL=$(echo "$candidate" | jq -r '.symbol')
  ENTRY=$(echo "$candidate" | jq -r '.entry_price | tonumber')
  SHARES=$(echo "$candidate" | jq -r '.shares | tonumber')
  POSITION_COST=$(echo "$candidate" | jq -r '.position_cost | tonumber')
  CATALYST=$(echo "$candidate" | jq -r '.catalyst')
  SECTOR=$(echo "$candidate" | jq -r '.sector // "Unknown"')
  TRAIL_PCT=$(echo "$candidate" | jq -r '.trailing_stop_pct // 10')

  log ""
  log "── Evaluating $SYMBOL (${SHARES} sh @ \$${ENTRY}, cost \$${POSITION_COST}) ──"

  # GATE 1: max positions after fill <= 5
  if [[ $((POS_COUNT + TRADES_EXECUTED + 1)) -gt 5 ]]; then
    SKIPPED_LIST+="${SYMBOL}: max_positions; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: max positions reached"
    continue
  fi

  # GATE 2: max 3 trades/week
  if [[ $((TRADES_THIS_WEEK + TRADES_EXECUTED + 1)) -gt 3 ]]; then
    SKIPPED_LIST+="${SYMBOL}: weekly_cap; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: weekly trade cap reached"
    continue
  fi

  # GATE 3: position cost <= 20% del capital operativo (dinámico sobre equity real)
  EXCEEDS_POSITION=$(python3 -c "print(1 if $POSITION_COST > $MAX_POS_SIZE else 0)")
  if [[ "$EXCEEDS_POSITION" == "1" ]]; then
    SKIPPED_LIST+="${SYMBOL}: pos_cost_>20pct; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: position cost \$$POSITION_COST > 20% del equity (\$$MAX_POS_SIZE)"
    continue
  fi

  # GATE 4: capital cap enforcement
  EXCEEDS_CAP=$(python3 -c "print(1 if $POSITION_COST > $CAPITAL_AVAILABLE else 0)")
  if [[ "$EXCEEDS_CAP" == "1" ]]; then
    SKIPPED_LIST+="${SYMBOL}: cap_exceeded; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: would exceed \$$OPERATING_CAPITAL cap (available \$$CAPITAL_AVAILABLE)"
    continue
  fi

  # GATE 5: enough Alpaca cash
  EXCEEDS_CASH=$(python3 -c "print(1 if $POSITION_COST > $CASH else 0)")
  if [[ "$EXCEEDS_CASH" == "1" ]]; then
    SKIPPED_LIST+="${SYMBOL}: insufficient_cash; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: insufficient Alpaca cash"
    continue
  fi

  # GATE 6: daytrade count
  if [[ "$DAYTRADE_COUNT" -ge 3 ]]; then
    SKIPPED_LIST+="${SYMBOL}: pdt_limit; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: PDT limit reached ($DAYTRADE_COUNT/3)"
    continue
  fi

  # GATE 7: verify symbol is tradeable + spread OK
  QUOTE=$(bash "$SCRIPTS/alpaca.sh" quote "$SYMBOL" 2>/dev/null || echo '{}')
  BID=$(echo "$QUOTE" | jq -r '.quote.bp // 0')
  ASK=$(echo "$QUOTE" | jq -r '.quote.ap // 0')

  ZERO_QUOTE=$(python3 -c "print(1 if $BID == 0 or $ASK == 0 else 0)")
  if [[ "$ZERO_QUOTE" == "1" ]]; then
    SKIPPED_LIST+="${SYMBOL}: halted_or_no_quote; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: halted or no quote (bid=$BID, ask=$ASK)"
    continue
  fi

  WIDE_SPREAD=$(python3 -c "spread=($ASK-$BID)/$ASK; print(1 if spread > 0.005 else 0)")
  if [[ "$WIDE_SPREAD" == "1" ]]; then
    SKIPPED_LIST+="${SYMBOL}: spread_>0.5%; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    log "SKIP: spread too wide (bid=$BID, ask=$ASK)"
    continue
  fi

  # ALL GATES PASSED → EXECUTE
  log "ALL GATES PASSED. Executing market buy..."

  BUY_RESULT=$(bash "$SCRIPTS/alpaca.sh" buy "$SYMBOL" "$SHARES" market 2>&1) || {
    log "BUY FAILED: $BUY_RESULT"
    alert "Market-open: BUY de $SYMBOL falló. $BUY_RESULT"
    SKIPPED_LIST+="${SYMBOL}: buy_api_error; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    continue
  }

  BUY_ORDER_ID=$(echo "$BUY_RESULT" | jq -r '.id // empty')
  if [[ -z "$BUY_ORDER_ID" ]]; then
    log "BUY response had no order ID: $BUY_RESULT"
    SKIPPED_LIST+="${SYMBOL}: no_order_id; "
    TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
    continue
  fi

  log "BUY placed (order_id=$BUY_ORDER_ID). Waiting for fill..."
  sleep 3

  # Place trailing stop immediately
  STOP_RESULT=$(bash "$SCRIPTS/alpaca.sh" trailing-stop "$SYMBOL" "$SHARES" "$TRAIL_PCT" 2>&1) || {
    log "TRAILING STOP FAILED — falling back to fixed stop"
    STOP_PRICE=$(python3 -c "print(round($ENTRY * 0.93, 2))")
    STOP_RESULT=$(bash "$SCRIPTS/alpaca.sh" fixed-stop "$SYMBOL" "$SHARES" "$STOP_PRICE" 2>&1) || {
      log "FIXED STOP ALSO FAILED — closing position immediately"
      alert "🚨 $SYMBOL: stops bloqueados. Cerrando posición."
      bash "$SCRIPTS/alpaca.sh" close "$SYMBOL" > /dev/null 2>&1 || true
      SKIPPED_LIST+="${SYMBOL}: stop_failed_closed; "
      TRADES_SKIPPED=$((TRADES_SKIPPED + 1))
      continue
    }
  }

  STOP_ORDER_ID=$(echo "$STOP_RESULT" | jq -r '.id // empty')
  log "Stop placed (order_id=$STOP_ORDER_ID)"

  # Log to TRADE-LOG
  TARGET_PRICE=$(echo "$candidate" | jq -r '.target_price')
  cat >> "$TRADE_LOG" <<EOF

### $DATE — Trade Entry: $SYMBOL
- **Ticker**: $SYMBOL
- **Side**: BUY
- **Shares**: $SHARES
- **Entry price**: \$$ENTRY (intended)
- **Position cost**: \$$POSITION_COST
- **Stop**: trailing $TRAIL_PCT% GTC (order_id: $STOP_ORDER_ID)
- **Target**: \$$TARGET_PRICE
- **Catalyst**: $CATALYST
- **Sector**: $SECTOR
- **Buy order_id**: $BUY_ORDER_ID
- **Capital used after**: \$$(python3 -c "print(round($CAPITAL_USED + $POSITION_COST, 2))") / \$$OPERATING_CAPITAL
EOF

  EXECUTED_LIST+="${SYMBOL}(${SHARES}sh \$${ENTRY}); "
  TRADES_EXECUTED=$((TRADES_EXECUTED + 1))
  CAPITAL_AVAILABLE=$(python3 -c "print(round($CAPITAL_AVAILABLE - $POSITION_COST, 2))")
  CAPITAL_USED=$(python3 -c "print(round($CAPITAL_USED + $POSITION_COST, 2))")
  CASH=$(python3 -c "print(round($CASH - $POSITION_COST, 2))")

  log "✓ $SYMBOL executed and stopped"
done

# ============================================
# STEP 5 — Telegram notification (always)
# ============================================
if [[ "$TRADES_EXECUTED" -gt 0 ]]; then
  MSG="📊 MARKET-OPEN $DATE

✅ Ejecutados ($TRADES_EXECUTED): $EXECUTED_LIST
"
  if [[ "$TRADES_SKIPPED" -gt 0 ]]; then
    MSG+="❌ Saltados ($TRADES_SKIPPED): $SKIPPED_LIST
"
  fi
  MSG+="
Capital usado: \$$CAPITAL_USED / \$$OPERATING_CAPITAL
Stops: trailing GTC en todas"
  notify "$MSG"
else
  MSG="📊 MARKET-OPEN $DATE

No se ejecutaron trades hoy.
$( [[ "$TRADES_SKIPPED" -gt 0 ]] && echo "Saltados ($TRADES_SKIPPED): $SKIPPED_LIST" || echo "No había candidatos válidos." )"
  notify "$MSG"
fi

log ""
log "Market-open complete. Executed=$TRADES_EXECUTED Skipped=$TRADES_SKIPPED"
exit 0
