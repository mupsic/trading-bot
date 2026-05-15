#!/usr/bin/env bash

# ============================================
# MIDDAY POSITION MONITOR (bash puro, sin Claude)
# ============================================
# Hard stop -7%: cierra cualquier posición que toque ese umbral
# Tighten trailing: +20% → 5%, +15% → 7%
# Drawdown circuit breaker: si operating equity -10% desde peak → pausa bot
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
STRATEGY="$MEMORY/TRADING-STRATEGY.md"
EQUITY_HISTORY="$MEMORY/.equity-history.jsonl"

DATE=$(date '+%Y-%m-%d')
TS=$(date '+%Y-%m-%d %H:%M:%S')

log() { echo "[$(date '+%H:%M:%S')] $*"; }
notify() { bash "$SCRIPTS/telegram.sh" send "$1" > /dev/null 2>&1 || true; }
alert() { bash "$SCRIPTS/telegram.sh" alert "WARNING" "$1" > /dev/null 2>&1 || true; }
critical() { bash "$SCRIPTS/telegram.sh" alert "CRITICAL" "$1" > /dev/null 2>&1 || true; }

# ============================================
# STEP 1 — Pull state
# ============================================
ACCOUNT=$(bash "$SCRIPTS/alpaca.sh" account 2>/dev/null)
EQUITY=$(echo "$ACCOUNT" | jq -r '.equity | tonumber')

POSITIONS=$(bash "$SCRIPTS/alpaca.sh" positions 2>/dev/null)
POS_COUNT=$(echo "$POSITIONS" | jq 'length')

ORDERS=$(bash "$SCRIPTS/alpaca.sh" orders 2>/dev/null)

# Operating equity (capped)
OPERATING_EQUITY=$(python3 -c "print(min($OPERATING_CAPITAL, $EQUITY))")

# Peak equity (from history)
PEAK=$OPERATING_EQUITY
if [[ -f "$EQUITY_HISTORY" ]]; then
  PEAK=$(python3 <<PYEOF
import json
peak = $OPERATING_EQUITY
try:
    with open("$EQUITY_HISTORY") as f:
        for line in f:
            try:
                d = json.loads(line)
                peak = max(peak, d.get("operating_equity", 0), d.get("peak_equity", 0))
            except:
                pass
except FileNotFoundError:
    pass
print(peak)
PYEOF
)
fi

DRAWDOWN_PCT=$(python3 -c "print(round(($PEAK - $OPERATING_EQUITY) / $PEAK * 100, 2)) if $PEAK > 0 else print(0)")
log "Operating equity=\$$OPERATING_EQUITY | Peak=\$$PEAK | Drawdown=${DRAWDOWN_PCT}%"

# ============================================
# STEP 2 — Drawdown circuit breaker
# ============================================
TRIPPED=$(python3 -c "print(1 if $DRAWDOWN_PCT >= 10 else 0)")
if [[ "$TRIPPED" == "1" ]]; then
  if ! grep -q "DRAWDOWN_CIRCUIT_BREAKER_TRIPPED" "$STRATEGY" 2>/dev/null; then
    NEXT_WEEK=$(python3 -c "from datetime import date,timedelta; print((date.today()+timedelta(days=7)).isoformat())")
    cat >> "$STRATEGY" <<EOF

## Active Constraints (auto-added $DATE)
- DRAWDOWN_CIRCUIT_BREAKER_TRIPPED: drawdown ${DRAWDOWN_PCT}% from peak \$$PEAK
- NO_NEW_TRADES_UNTIL: $NEXT_WEEK
EOF
    critical "🚨 CIRCUIT BREAKER: drawdown ${DRAWDOWN_PCT}% desde peak (\$$PEAK → \$$OPERATING_EQUITY). NO new trades hasta $NEXT_WEEK. Posiciones existentes se siguen gestionando."
    log "Circuit breaker tripped. Flag written to STRATEGY."
  fi
fi

# ============================================
# STEP 3 — Hard stop check (-7%) + trailing tighten
# ============================================
ACTIONS_TAKEN=0
ACTION_LOG=""

for i in $(seq 0 $((POS_COUNT - 1))); do
  pos=$(echo "$POSITIONS" | jq -c ".[$i]")
  SYMBOL=$(echo "$pos" | jq -r '.symbol')
  QTY=$(echo "$pos" | jq -r '.qty | tonumber')
  AVG_ENTRY=$(echo "$pos" | jq -r '.avg_entry_price | tonumber')
  CURRENT=$(echo "$pos" | jq -r '.current_price | tonumber')
  UNREALIZED_PL=$(echo "$pos" | jq -r '.unrealized_pl | tonumber')
  UNREALIZED_PCT=$(echo "$pos" | jq -r '.unrealized_plpc | tonumber')

  log ""
  log "── $SYMBOL: $QTY sh @ \$$AVG_ENTRY → \$$CURRENT | P&L: \$$UNREALIZED_PL ($(python3 -c "print(round($UNREALIZED_PCT*100,2))")%) ──"

  # Find existing stop order for this symbol (trailing_stop or stop)
  STOP_ORDER_ID=$(echo "$ORDERS" | jq -r --arg sym "$SYMBOL" \
    '.[] | select(.symbol == $sym) | select(.type == "trailing_stop" or .type == "stop") | .id' | head -1)

  # CHECK 1: hard stop -7%
  HARD_STOP=$(python3 -c "print(1 if $UNREALIZED_PCT <= -0.07 else 0)")
  if [[ "$HARD_STOP" == "1" ]]; then
    log "HARD STOP triggered. Closing position."

    # Cancel existing stop order first (if any)
    if [[ -n "$STOP_ORDER_ID" ]]; then
      bash "$SCRIPTS/alpaca.sh" cancel "$STOP_ORDER_ID" > /dev/null 2>&1 || true
    fi

    # Close at market
    bash "$SCRIPTS/alpaca.sh" close "$SYMBOL" > /dev/null 2>&1 || {
      alert "Midday: error cerrando $SYMBOL en hard stop"
      continue
    }

    # Log to TRADE-LOG
    cat >> "$TRADE_LOG" <<EOF

### $TS — POSITION CLOSED (Hard Stop -7%)
- **Ticker**: $SYMBOL
- **Reason**: unrealized_plpc reached $(python3 -c "print(round($UNREALIZED_PCT*100,2))")%
- **Exit price**: ~\$$CURRENT (market order)
- **Realized P&L**: \$$UNREALIZED_PL
- **Hold**: from entry @ \$$AVG_ENTRY
EOF

    alert "🔴 $SYMBOL cerrado a -$(python3 -c "print(round(abs($UNREALIZED_PCT)*100,1))")%. Realizado: \$$UNREALIZED_PL"
    ACTION_LOG+="🔴 $SYMBOL cut at -7%; "
    ACTIONS_TAKEN=$((ACTIONS_TAKEN + 1))
    continue
  fi

  # CHECK 2: tighten trailing stops on winners
  TIGHTEN=0
  NEW_TRAIL=0

  PCT_HUNDREDS=$(python3 -c "print(int($UNREALIZED_PCT * 10000))")  # e.g. 0.15 → 1500
  if [[ "$PCT_HUNDREDS" -ge 2000 ]]; then
    TIGHTEN=1
    NEW_TRAIL=5
  elif [[ "$PCT_HUNDREDS" -ge 1500 ]]; then
    TIGHTEN=1
    NEW_TRAIL=7
  fi

  if [[ "$TIGHTEN" == "1" && -n "$STOP_ORDER_ID" ]]; then
    # Read current trail percent from existing order
    CURRENT_TRAIL=$(echo "$ORDERS" | jq -r --arg sym "$SYMBOL" \
      '.[] | select(.symbol == $sym) | select(.type == "trailing_stop") | .trail_percent // empty' | head -1)

    if [[ -n "$CURRENT_TRAIL" ]]; then
      # Only tighten if new trail is tighter (< current)
      SHOULD_UPDATE=$(python3 -c "print(1 if $NEW_TRAIL < $CURRENT_TRAIL else 0)")

      if [[ "$SHOULD_UPDATE" == "1" ]]; then
        # Check 3%-from-price guardrail
        # If new stop would be within 3% of current price → skip
        WITHIN_3PCT=$(python3 -c "print(1 if $NEW_TRAIL < 3 else 0)")
        if [[ "$WITHIN_3PCT" == "1" ]]; then
          log "Skip tighten: would be within 3% guardrail"
        else
          log "Tighten $SYMBOL: $CURRENT_TRAIL% → $NEW_TRAIL%"

          # Cancel old, place new
          bash "$SCRIPTS/alpaca.sh" cancel "$STOP_ORDER_ID" > /dev/null 2>&1 || true
          sleep 1
          NEW_STOP=$(bash "$SCRIPTS/alpaca.sh" trailing-stop "$SYMBOL" "$QTY" "$NEW_TRAIL" 2>&1)

          # Log
          cat >> "$TRADE_LOG" <<EOF

### $TS — STOP TIGHTENED: $SYMBOL
- Position at +$(python3 -c "print(round($UNREALIZED_PCT*100,1))")%
- Trailing $CURRENT_TRAIL% → $NEW_TRAIL%
EOF

          notify "🟢 $SYMBOL en +$(python3 -c "print(round($UNREALIZED_PCT*100,1))")%. Trailing tightened a $NEW_TRAIL%"
          ACTION_LOG+="🟢 $SYMBOL trail→$NEW_TRAIL%; "
          ACTIONS_TAKEN=$((ACTIONS_TAKEN + 1))
        fi
      fi
    fi
  fi
done

# ============================================
# STEP 4 — Final Telegram if action taken
# ============================================
if [[ "$ACTIONS_TAKEN" -gt 0 ]]; then
  log ""
  log "Midday actions: $ACTIONS_TAKEN ($ACTION_LOG)"
else
  log "Midday: no actions taken. All positions within tolerance."
fi

exit 0
