#!/bin/bash

# ============================================
# CLICKUP NOTIFICATIONS WRAPPER
# ============================================
# Integra ClickUp Chat API para notificaciones y logging
# Uso: ./clickup.sh "BUY AAPL 100 @ $150" "TRADE_EXECUTED"
#

set -e

# Load environment
source "$(dirname "$0")/../.env"

# Configuration
CLICKUP_API_TOKEN="${CLICKUP_API_TOKEN}"
CLICKUP_WORKSPACE_ID="${CLICKUP_WORKSPACE_ID}"
CLICKUP_CHAT_ID="${CLICKUP_CHAT_ID}"

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ============================================
# FUNCTION: Send Message to ClickUp
# ============================================
send_message() {
    local MESSAGE=$1
    local MESSAGE_TYPE=${2:-INFO}

    echo "[$TIMESTAMP] Sending to ClickUp: [$MESSAGE_TYPE] $MESSAGE"

    # Build formatted message
    FORMATTED_MESSAGE="[$MESSAGE_TYPE] $TIMESTAMP
$MESSAGE"

    PAYLOAD=$(cat <<EOF
{
    "text": "$FORMATTED_MESSAGE"
}
EOF
)

    RESPONSE=$(curl -s -X POST \
        -H "Authorization: Bearer $CLICKUP_API_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$PAYLOAD" \
        "https://api.clickup.com/v2/team/$CLICKUP_WORKSPACE_ID/chat_message?channel_id=$CLICKUP_CHAT_ID")

    echo "$RESPONSE" | jq '.'
}

# ============================================
# FUNCTION: Log Trade Execution
# ============================================
log_trade() {
    local SIDE=$1          # BUY, SELL
    local SYMBOL=$2        # AAPL
    local QTY=$3           # 100
    local PRICE=$4         # 150.25
    local REASON=$5        # Strategy: Momentum

    MESSAGE="📊 TRADE EXECUTED
SIDE: $SIDE
SYMBOL: $SYMBOL
QTY: $QTY
PRICE: \$$PRICE
REASON: $REASON"

    send_message "$MESSAGE" "TRADE"
}

# ============================================
# FUNCTION: Log Alert
# ============================================
log_alert() {
    local ALERT_TYPE=$1  # WARNING, ERROR, INFO
    local MESSAGE=$2

    send_message "$MESSAGE" "$ALERT_TYPE"
}

# ============================================
# FUNCTION: Log Daily Summary
# ============================================
log_daily_summary() {
    local GAINS=$1         # +$500
    local TRADES=$2        # 2
    local WIN_RATE=$3      # 66%
    local NOTES=$4         # Additional notes

    MESSAGE="📈 DAILY SUMMARY
GAINS: $GAINS
TRADES: $TRADES
WIN RATE: $WIN_RATE
NOTES: $NOTES"

    send_message "$MESSAGE" "DAILY_SUMMARY"
}

# ============================================
# FUNCTION: Log Market Analysis
# ============================================
log_analysis() {
    local MARKET_CONDITION=$1  # Bullish, Bearish, Neutral
    local KEY_POINTS=$2        # Summary of analysis

    MESSAGE="🔍 MARKET ANALYSIS
CONDITION: $MARKET_CONDITION
INSIGHTS: $KEY_POINTS"

    send_message "$MESSAGE" "ANALYSIS"
}

# ============================================
# FUNCTION: Fallback to Local Log
# ============================================
fallback_log() {
    local MESSAGE=$1
    local LOG_FILE="../logs/clickup-fallback.log"

    # Create logs directory if doesn't exist
    mkdir -p "$(dirname "$0")/../logs"

    echo "[$TIMESTAMP] $MESSAGE" >> "$LOG_FILE"
    echo "⚠️  Fallback: Message logged to $LOG_FILE"
}

# ============================================
# MAIN
# ============================================
COMMAND=$1

case "$COMMAND" in
    send)
        if [ -z "$2" ]; then
            echo "Usage: $0 send \"MESSAGE\" [TYPE]"
            exit 1
        fi
        send_message "$2" "${3:-INFO}"
        ;;
    trade)
        if [ -z "$4" ]; then
            echo "Usage: $0 trade SIDE SYMBOL QTY PRICE [REASON]"
            exit 1
        fi
        log_trade "$2" "$3" "$4" "$5" "${6:-No reason provided}"
        ;;
    alert)
        if [ -z "$3" ]; then
            echo "Usage: $0 alert TYPE MESSAGE"
            exit 1
        fi
        log_alert "$2" "$3"
        ;;
    summary)
        if [ -z "$4" ]; then
            echo "Usage: $0 summary GAINS TRADES WIN_RATE [NOTES]"
            exit 1
        fi
        log_daily_summary "$2" "$3" "$4" "${5:-No additional notes}"
        ;;
    analysis)
        if [ -z "$3" ]; then
            echo "Usage: $0 analysis MARKET_CONDITION INSIGHTS"
            exit 1
        fi
        log_analysis "$2" "$3"
        ;;
    fallback)
        if [ -z "$2" ]; then
            echo "Usage: $0 fallback MESSAGE"
            exit 1
        fi
        fallback_log "$2"
        ;;
    *)
        echo "Usage: $0 {send|trade|alert|summary|analysis|fallback} [ARGS]"
        echo ""
        echo "Examples:"
        echo "  ./clickup.sh send \"Bot started\"         # Send message"
        echo "  ./clickup.sh trade BUY AAPL 100 150.25 # Log trade"
        echo "  ./clickup.sh alert WARNING \"Low capital\" # Send alert"
        echo "  ./clickup.sh summary \"+500\" 2 \"66%\"   # Daily summary"
        echo "  ./clickup.sh analysis Bullish \"Tech up\" # Market analysis"
        exit 1
        ;;
esac
