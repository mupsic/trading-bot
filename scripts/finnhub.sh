#!/usr/bin/env bash
# Finnhub API wrapper. Financial market data and news.
# Usage: bash scripts/finnhub.sh <subcommand> [args...]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

: "${FINNHUB_API_KEY:?FINNHUB_API_KEY not set in environment}"

API="https://finnhub.io/api/v1"

cmd="${1:-}"
shift || true

case "$cmd" in
  quote)
    # Get latest quote for symbol
    sym="${1:?usage: quote SYM}"
    curl -fsS "${API}/quote?symbol=${sym}&token=${FINNHUB_API_KEY}"
    ;;

  news)
    # Get news for symbol or general market
    sym="${1:-}"
    if [[ -z "$sym" ]]; then
      # General market news (no symbol)
      curl -fsS "${API}/news?category=general&token=${FINNHUB_API_KEY}"
    else
      # News for specific symbol
      curl -fsS "${API}/company-news?symbol=${sym}&from=$(date -d '1 week ago' '+%Y-%m-%d')&to=$(date '+%Y-%m-%d')&token=${FINNHUB_API_KEY}"
    fi
    ;;

  earnings)
    # Get earnings calendar
    curl -fsS "${API}/calendar/earnings?token=${FINNHUB_API_KEY}"
    ;;

  economic)
    # Get economic calendar
    curl -fsS "${API}/calendar/economic?token=${FINNHUB_API_KEY}"
    ;;

  ipo)
    # Get IPO calendar
    curl -fsS "${API}/calendar/ipo?token=${FINNHUB_API_KEY}"
    ;;

  peers)
    # Get company peers
    sym="${1:?usage: peers SYM}"
    curl -fsS "${API}/stock/peers?symbol=${sym}&token=${FINNHUB_API_KEY}"
    ;;

  profile)
    # Get company profile
    sym="${1:?usage: profile SYM}"
    curl -fsS "${API}/stock/profile2?symbol=${sym}&token=${FINNHUB_API_KEY}"
    ;;

  *)
    echo "Usage: bash scripts/finnhub.sh <quote|news|earnings|economic|ipo|peers|profile> [args]" >&2
    exit 1
    ;;
esac

echo
