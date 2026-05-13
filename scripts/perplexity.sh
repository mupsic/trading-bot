#!/bin/bash

# ============================================
# PERPLEXITY RESEARCH WRAPPER
# ============================================
# Integra Perplexity API para research con citas
# Uso: ./perplexity.sh "¿Qué noticias económicas hay hoy?"
#

set -e

# Load environment
source "$(dirname "$0")/../.env"

# Configuration
PERPLEXITY_API_KEY="${PERPLEXITY_API_KEY}"
PERPLEXITY_MODEL="${PERPLEXITY_MODEL:-sonar-pro}"

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ============================================
# FUNCTION: Query Perplexity
# ============================================
query_perplexity() {
    local QUERY=$1

    echo "[$TIMESTAMP] Querying Perplexity: $QUERY"
    echo ""

    PAYLOAD=$(cat <<EOF
{
    "model": "$PERPLEXITY_MODEL",
    "messages": [
        {
            "role": "user",
            "content": "$QUERY"
        }
    ],
    "temperature": 0.2,
    "top_p": 0.9,
    "return_citations": true
}
EOF
)

    RESPONSE=$(curl -s -X POST \
        -H "Authorization: Bearer $PERPLEXITY_API_KEY" \
        -H "Content-Type: application/json" \
        -d "$PAYLOAD" \
        "https://api.perplexity.ai/chat/completions")

    # Extract content and citations
    echo "$RESPONSE" | jq '.'
}

# ============================================
# FUNCTION: Market Research
# ============================================
market_research() {
    local QUERY="Análisis rápido del mercado hoy:
    1. Principales noticias económicas
    2. Futuros S&P 500 y Nasdaq
    3. Volatilidad del mercado
    4. Recomendaciones de sectores
    Responde concisamente con fuentes."

    query_perplexity "$QUERY"
}

# ============================================
# FUNCTION: Stock Research
# ============================================
stock_research() {
    local SYMBOL=$1
    local QUERY="Análisis de $SYMBOL hoy:
    1. Últimas noticias
    2. Cambios de precio y volumen
    3. Análisis técnico breve
    4. Recomendaciones de analistas
    Responde concisamente con fuentes confiables."

    query_perplexity "$QUERY"
}

# ============================================
# FUNCTION: Sector Analysis
# ============================================
sector_analysis() {
    local SECTOR=$1
    local QUERY="Análisis del sector de $SECTOR hoy:
    1. Desempeño general
    2. Principales movers
    3. Catalizadores
    4. Outlook
    Responde concisamente con fuentes."

    query_perplexity "$QUERY"
}

# ============================================
# MAIN
# ============================================
COMMAND=$1

case "$COMMAND" in
    query)
        if [ -z "$2" ]; then
            echo "Usage: $0 query \"YOUR_QUESTION\""
            exit 1
        fi
        query_perplexity "$2"
        ;;
    market)
        market_research
        ;;
    stock)
        if [ -z "$2" ]; then
            echo "Usage: $0 stock SYMBOL"
            exit 1
        fi
        stock_research "$2"
        ;;
    sector)
        if [ -z "$2" ]; then
            echo "Usage: $0 sector SECTOR_NAME"
            exit 1
        fi
        sector_analysis "$2"
        ;;
    *)
        echo "Usage: $0 {query|market|stock|sector} [ARGS]"
        echo ""
        echo "Examples:"
        echo "  ./perplexity.sh query \"¿Qué noticias hay de Tesla?\""
        echo "  ./perplexity.sh market                 # Daily market analysis"
        echo "  ./perplexity.sh stock AAPL             # Stock-specific research"
        echo "  ./perplexity.sh sector Technology      # Sector analysis"
        exit 1
        ;;
esac
