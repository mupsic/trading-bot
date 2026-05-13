#!/usr/bin/env bash

# ============================================
# ALPACA TRADING WRAPPER
# ============================================
# Integra Alpaca REST API para ejecución de órdenes
# Soporta todos los subcomandos necesarios para las 5 routines del bot
# ============================================

set -euo pipefail

# Load environment
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"
if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

# Validate credentials
: "${ALPACA_API_KEY:?ALPACA_API_KEY not set in environment}"
: "${ALPACA_API_SECRET:?ALPACA_API_SECRET not set in environment}"

# Configuration
API="${ALPACA_BASE_URL:-https://paper-api.alpaca.markets}/v2"
DATA="${ALPACA_DATA_URL:-https://data.alpaca.markets/v2}"
H_KEY="APCA-API-KEY-ID: $ALPACA_API_KEY"
H_SEC="APCA-API-SECRET-KEY: $ALPACA_API_SECRET"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ============================================
# DISPATCHER
# ============================================
cmd="${1:-}"
shift || true

case "$cmd" in

  # ----- READ OPERATIONS -----

  account)
    # Account state: equity, cash, buying_power, daytrade_count, pattern_day_trader
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/account"
    ;;

  positions)
    # All open positions w/ unrealized P&L
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/positions"
    ;;

  position)
    # Single position by symbol
    sym="${1:?usage: position SYMBOL}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/positions/$sym"
    ;;

  quote)
    # Latest bid/ask quote
    sym="${1:?usage: quote SYMBOL}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$DATA/stocks/$sym/quotes/latest"
    ;;

  orders)
    # List orders (default: open)
    status="${1:-open}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/orders?status=$status"
    ;;

  # ----- WRITE OPERATIONS (raw JSON) -----

  order)
    # POST new order with raw JSON
    # Example: order '{"symbol":"AAPL","qty":"4","side":"buy","type":"market","time_in_force":"day"}'
    body="${1:?usage: order '<json>'}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;

  # ----- WRITE OPERATIONS (helpers) -----

  buy)
    # Buy market order (helper)
    # Usage: buy SYMBOL QTY [type=market]
    sym="${1:?usage: buy SYMBOL QTY [market|limit] [limit_price]}"
    qty="${2:?usage: buy SYMBOL QTY [market|limit] [limit_price]}"
    type="${3:-market}"
    limit_price="${4:-}"

    if [[ "$type" == "limit" && -n "$limit_price" ]]; then
      body="{\"symbol\":\"$sym\",\"qty\":\"$qty\",\"side\":\"buy\",\"type\":\"limit\",\"limit_price\":\"$limit_price\",\"time_in_force\":\"day\"}"
    else
      body="{\"symbol\":\"$sym\",\"qty\":\"$qty\",\"side\":\"buy\",\"type\":\"market\",\"time_in_force\":\"day\"}"
    fi

    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;

  sell)
    # Sell market order (helper)
    sym="${1:?usage: sell SYMBOL QTY [market|limit] [limit_price]}"
    qty="${2:?usage: sell SYMBOL QTY [market|limit] [limit_price]}"
    type="${3:-market}"
    limit_price="${4:-}"

    if [[ "$type" == "limit" && -n "$limit_price" ]]; then
      body="{\"symbol\":\"$sym\",\"qty\":\"$qty\",\"side\":\"sell\",\"type\":\"limit\",\"limit_price\":\"$limit_price\",\"time_in_force\":\"day\"}"
    else
      body="{\"symbol\":\"$sym\",\"qty\":\"$qty\",\"side\":\"sell\",\"type\":\"market\",\"time_in_force\":\"day\"}"
    fi

    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;

  trailing-stop)
    # Trailing stop GTC order (helper)
    # Usage: trailing-stop SYMBOL QTY TRAIL_PCT
    # IMPORTANT: trail_percent must be a string like "10" for 10% (NOT 0.10)
    sym="${1:?usage: trailing-stop SYMBOL QTY TRAIL_PCT}"
    qty="${2:?usage: trailing-stop SYMBOL QTY TRAIL_PCT}"
    trail_pct="${3:?usage: trailing-stop SYMBOL QTY TRAIL_PCT  (e.g. 10 for 10%)}"

    body="{\"symbol\":\"$sym\",\"qty\":\"$qty\",\"side\":\"sell\",\"type\":\"trailing_stop\",\"trail_percent\":\"$trail_pct\",\"time_in_force\":\"gtc\"}"

    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;

  fixed-stop)
    # Fixed stop GTC order (fallback when trailing stops are PDT-blocked)
    # Usage: fixed-stop SYMBOL QTY STOP_PRICE
    sym="${1:?usage: fixed-stop SYMBOL QTY STOP_PRICE}"
    qty="${2:?usage: fixed-stop SYMBOL QTY STOP_PRICE}"
    stop_price="${3:?usage: fixed-stop SYMBOL QTY STOP_PRICE}"

    body="{\"symbol\":\"$sym\",\"qty\":\"$qty\",\"side\":\"sell\",\"type\":\"stop\",\"stop_price\":\"$stop_price\",\"time_in_force\":\"gtc\"}"

    curl -fsS -H "$H_KEY" -H "$H_SEC" -H "Content-Type: application/json" \
      -X POST -d "$body" "$API/orders"
    ;;

  # ----- DELETE OPERATIONS -----

  cancel)
    # Cancel single order by ID
    oid="${1:?usage: cancel ORDER_ID}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/orders/$oid"
    ;;

  cancel-all)
    # Cancel all open orders
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/orders"
    ;;

  close)
    # Close single position (market sell)
    sym="${1:?usage: close SYMBOL}"
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/positions/$sym"
    ;;

  close-all)
    # Close ALL positions (emergency button)
    curl -fsS -H "$H_KEY" -H "$H_SEC" -X DELETE "$API/positions"
    ;;

  # ----- SAFETY CHECKS -----

  daytrade-check)
    # Check daytrade count (PDT awareness)
    # Returns: 0 if room for more day trades, 1 if at limit
    response=$(curl -fsS -H "$H_KEY" -H "$H_SEC" "$API/account")
    count=$(echo "$response" | python3 -c "import json,sys; print(json.load(sys.stdin).get('daytrade_count','0'))")
    max="${BOT_MAX_DAYTRADES:-3}"
    echo "daytrade_count: $count / $max"
    if [[ "$count" -ge "$max" ]]; then
      echo "WARNING: PDT limit reached. No more day trades for 5 rolling business days."
      exit 1
    fi
    exit 0
    ;;

  operating-capital)
    # Returns the effective operating capital (overrides Alpaca equity)
    # Used by routines to enforce the $3k cap instead of using full $100k paper equity
    echo "${OPERATING_CAPITAL:-3000}"
    ;;

  # ----- HELP -----

  *)
    cat >&2 <<EOF
Usage: bash scripts/alpaca.sh <command> [args]

READ:
  account                          Get account info (equity, cash, daytrade_count)
  positions                        List all open positions w/ unrealized P&L
  position SYMBOL                  Get single position info
  quote SYMBOL                     Get latest bid/ask quote
  orders [status]                  List orders (default: open)

WRITE (raw):
  order '<json>'                   POST raw order JSON

WRITE (helpers):
  buy SYMBOL QTY [market|limit] [price]    Market buy (default)
  sell SYMBOL QTY [market|limit] [price]   Market sell (default)
  trailing-stop SYMBOL QTY TRAIL_PCT       e.g. trailing-stop AAPL 4 10  (10%)
  fixed-stop SYMBOL QTY STOP_PRICE         Fallback fixed stop GTC

DELETE:
  cancel ORDER_ID                  Cancel specific order
  cancel-all                       Cancel all open orders
  close SYMBOL                     Close single position (market sell)
  close-all                        EMERGENCY: close all positions

SAFETY:
  daytrade-check                   Verify PDT room (exits 1 if at limit)
  operating-capital                Returns OPERATING_CAPITAL from .env (\$3000)

NOTAS:
  - trail_percent va como string: "10" = 10% (NO 0.10)
  - Todas las órdenes con qty como string ("4" no 4)
  - Paper trading endpoint por defecto (ALPACA_BASE_URL en .env)
EOF
    exit 1
    ;;
esac

echo
