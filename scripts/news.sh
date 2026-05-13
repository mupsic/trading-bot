#!/bin/bash

# Load .env
set -a
source "$(dirname "$0")/../.env"
set +a

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

case "$1" in
    market)
        echo "[$TIMESTAMP] 📰 TOP STOCK MARKET NEWS"
        echo "===================================="
        curl -s "https://newsapi.org/v2/everything?q=stock%20market&sortBy=publishedAt&language=en&pageSize=5&apiKey=$NEWSAPI_API_KEY" | jq -r '.articles[] | "📌 \(.title)\n   Source: \(.source.name)\n"'
        ;;
    stock)
        if [ -z "$2" ]; then
            echo "Usage: $0 stock SYMBOL"
            exit 1
        fi
        echo "[$TIMESTAMP] 📊 STOCK NEWS: $2"
        echo "===================================="
        curl -s "https://newsapi.org/v2/everything?q=$2%20stock&language=en&pageSize=5&apiKey=$NEWSAPI_API_KEY" | jq -r '.articles[] | "📌 \(.title)\n   Source: \(.source.name)\n"'
        ;;
    sector)
        if [ -z "$2" ]; then
            echo "Usage: $0 sector SECTOR_NAME"
            exit 1
        fi
        echo "[$TIMESTAMP] 🏭 SECTOR: $2"
        echo "===================================="
        curl -s "https://newsapi.org/v2/everything?q=$2%20sector&language=en&pageSize=5&apiKey=$NEWSAPI_API_KEY" | jq -r '.articles[] | "📌 \(.title)\n   Source: \(.source.name)\n"'
        ;;
    *)
        echo "Usage: $0 {market|stock|sector} [ARGS]"
        echo "Examples:"
        echo "  ./news.sh market          # Daily market news"
        echo "  ./news.sh stock AAPL      # Stock news"
        echo "  ./news.sh sector Tech     # Sector news"
        exit 1
        ;;
esac
