#!/bin/bash

# Telegram Bot Integration
# Sends trading notifications to your Telegram chat

# Load .env
set -a
source "$(dirname "$0")/../.env"
set +a

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Validate required variables
if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
    echo "ERROR: TELEGRAM_BOT_TOKEN not set in .env"
    exit 1
fi

if [ -z "$TELEGRAM_CHAT_ID" ]; then
    echo "ERROR: TELEGRAM_CHAT_ID not set in .env"
    exit 1
fi

TELEGRAM_API_URL="https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage"

# Function to send a message
send_message() {
    local message="$1"
    local parse_mode="${2:-HTML}"  # Default to HTML formatting

    curl -s -X POST "$TELEGRAM_API_URL" \
        -H "Content-Type: application/json" \
        -d "{
            \"chat_id\": \"$TELEGRAM_CHAT_ID\",
            \"text\": \"$message\",
            \"parse_mode\": \"$parse_mode\"
        }" > /dev/null

    echo "[$TIMESTAMP] ✅ Message sent to Telegram"
}

# Function to send trade notification
send_trade() {
    local action="$1"      # BUY / SELL
    local symbol="$2"      # AAPL, GOOGL, etc.
    local quantity="$3"    # 100
    local price="$4"       # 150.25
    local reason="${5:-Market entry}"

    local message="<b>📊 TRADE EXECUTION</b>
<b>Action:</b> $action
<b>Symbol:</b> $symbol
<b>Quantity:</b> $quantity
<b>Price:</b> \$$price
<b>Reason:</b> $reason
<b>Time:</b> $TIMESTAMP"

    send_message "$message" "HTML"
}

# Function to send alert
send_alert() {
    local alert_type="$1"  # WARNING / CRITICAL / INFO
    local message="$2"

    local emoji="ℹ️"
    [ "$alert_type" = "WARNING" ] && emoji="⚠️"
    [ "$alert_type" = "CRITICAL" ] && emoji="🚨"

    local full_message="<b>$emoji $alert_type</b>
$message
<b>Time:</b> $TIMESTAMP"

    send_message "$full_message" "HTML"
}

# Function to send position update
send_position_update() {
    local symbol="$1"
    local quantity="$2"
    local entry_price="$3"
    local current_price="$4"
    local pnl="$5"
    local pnl_percent="$6"

    # Determine emoji based on P&L
    local emoji="📈"
    if (( $(echo "$pnl < 0" | bc -l) )); then
        emoji="📉"
    fi

    local message="<b>$emoji POSITION UPDATE</b>
<b>Symbol:</b> $symbol
<b>Quantity:</b> $quantity
<b>Entry:</b> \$$entry_price
<b>Current:</b> \$$current_price
<b>P&L:</b> \$$pnl ($pnl_percent%)
<b>Time:</b> $TIMESTAMP"

    send_message "$message" "HTML"
}

# Function to send daily summary
send_daily_summary() {
    local daily_pnl="$1"
    local trades_executed="$2"
    local win_rate="$3"
    local best_trade="$4"
    local worst_trade="$5"

    local emoji="📈"
    if (( $(echo "$daily_pnl < 0" | bc -l) )); then
        emoji="📉"
    fi

    local message="<b>$emoji DAILY SUMMARY</b>
<b>P&L:</b> \$$daily_pnl
<b>Trades:</b> $trades_executed executed
<b>Win Rate:</b> $win_rate%
<b>Best:</b> $best_trade
<b>Worst:</b> $worst_trade
<b>Time:</b> $TIMESTAMP"

    send_message "$message" "HTML"
}

# Main command handling
case "$1" in
    send)
        # Direct message: ./telegram.sh send "Your message"
        send_message "$2"
        ;;
    trade)
        # Trade notification: ./telegram.sh trade BUY AAPL 100 150.25 "breakout above 20-day MA"
        send_trade "$2" "$3" "$4" "$5" "$6"
        ;;
    alert)
        # Alert: ./telegram.sh alert WARNING "Capital running low"
        send_alert "$2" "$3"
        ;;
    position)
        # Position update: ./telegram.sh position AAPL 100 150.00 152.50 200 1.67
        send_position_update "$2" "$3" "$4" "$5" "$6" "$7"
        ;;
    summary)
        # Daily summary: ./telegram.sh summary 700 2 100 "AAPL +500" "GOOGL -100"
        send_daily_summary "$2" "$3" "$4" "$5" "$6"
        ;;
    test)
        # Test connection
        send_message "<b>🤖 Bot Test</b>
Your Telegram integration is working!
Chat ID: <code>$TELEGRAM_CHAT_ID</code>" "HTML"
        ;;
    *)
        echo "Usage: $0 {send|trade|alert|position|summary|test} [ARGS]"
        echo ""
        echo "Examples:"
        echo "  ./telegram.sh send 'Hello World'"
        echo "  ./telegram.sh trade BUY AAPL 100 150.25 'breakout'"
        echo "  ./telegram.sh alert WARNING 'Capital running low'"
        echo "  ./telegram.sh position AAPL 100 150.00 152.50 200 1.67"
        echo "  ./telegram.sh summary 700 2 100 'AAPL +500' 'GOOGL -100'"
        echo "  ./telegram.sh test"
        exit 1
        ;;
esac
