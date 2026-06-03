#!/usr/bin/env bash

# ============================================
# TELEGRAM LISTENER
# ============================================
# Polls Telegram getUpdates and executes commands.
# Designed to be called every 1-2 minutes by a scheduled task.
#
# Supported commands (only from authorized TELEGRAM_CHAT_ID):
#   /status      - Account snapshot + positions + pause state
#   /positions   - List open positions
#   /pause       - Stop opening new positions
#   /resume      - Re-enable new positions
#   /closeall    - 🚨 Close ALL positions (emergency)
#   /cancelall   - Cancel pending orders
#   /help        - Show command list
# ============================================

set -euo pipefail

# Load environment
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ENV_FILE="$ROOT/.env"
if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

: "${TELEGRAM_BOT_TOKEN:?TELEGRAM_BOT_TOKEN not set}"
: "${TELEGRAM_CHAT_ID:?TELEGRAM_CHAT_ID not set}"

SCRIPTS="$ROOT/scripts"
STATE_FILE="$ROOT/memory/.telegram-state.json"
BOT_STATE="$ROOT/memory/BOT-STATE.md"
WEBHOOK_FLAG="$ROOT/memory/.telegram-webhook-cleared"

# One-time webhook cleanup: ensures getUpdates works.
# Webhook + getUpdates are mutually exclusive in Telegram. If a webhook is set,
# getUpdates returns 409. This call is idempotent (safe to repeat).
if [[ ! -f "$WEBHOOK_FLAG" ]]; then
  echo "[$(date)] First run — clearing any existing webhook..."
  curl -sS "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/deleteWebhook?drop_pending_updates=false" > /dev/null 2>&1 || true
  touch "$WEBHOOK_FLAG"
fi

# Read last_update_id (default 0)
LAST_ID=0
if [[ -f "$STATE_FILE" ]]; then
  LAST_ID=$(jq -r '.last_update_id // 0' "$STATE_FILE")
fi

OFFSET=$((LAST_ID + 1))

# Poll Telegram. NOTE: no -f flag so we capture error response body for debugging.
RESPONSE=$(curl -sS "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getUpdates?offset=${OFFSET}&timeout=0&limit=20" 2>&1 || echo '{"ok":false,"error":"curl_failed"}')

OK=$(echo "$RESPONSE" | jq -r '.ok' 2>/dev/null || echo "parse_error")
if [[ "$OK" != "true" ]]; then
  echo "[$(date)] Telegram API error. Full response:" >&2
  echo "$RESPONSE" >&2

  # If 409 (Conflict: webhook is active), try to clear it and retry once
  ERROR_CODE=$(echo "$RESPONSE" | jq -r '.error_code // 0' 2>/dev/null || echo "0")
  if [[ "$ERROR_CODE" == "409" ]] || echo "$RESPONSE" | grep -qi "webhook"; then
    echo "[$(date)] Detected webhook conflict — clearing and retrying..." >&2
    curl -sS "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/deleteWebhook?drop_pending_updates=false" > /dev/null 2>&1 || true
    sleep 1
    RESPONSE=$(curl -sS "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getUpdates?offset=${OFFSET}&timeout=0&limit=20" 2>&1 || echo '{"ok":false}')
    OK=$(echo "$RESPONSE" | jq -r '.ok' 2>/dev/null || echo "false")
    if [[ "$OK" != "true" ]]; then
      echo "[$(date)] Retry also failed:" >&2
      echo "$RESPONSE" >&2
      exit 1
    fi
    echo "[$(date)] Retry succeeded after clearing webhook"
  else
    exit 1
  fi
fi

COUNT=$(echo "$RESPONSE" | jq '.result | length')
if [[ "$COUNT" -eq 0 ]]; then
  echo "[$(date)] No new messages"
  exit 0
fi

echo "[$(date)] Processing $COUNT new message(s)"

# Helper: send reply
reply() {
  bash "$SCRIPTS/telegram.sh" send "$1" > /dev/null
}

# Process each update
for i in $(seq 0 $((COUNT - 1))); do
  update=$(echo "$RESPONSE" | jq -c ".result[$i]")

  update_id=$(echo "$update" | jq -r '.update_id')
  chat_id=$(echo "$update" | jq -r '.message.chat.id // empty')
  text=$(echo "$update" | jq -r '.message.text // ""')

  # Authorization: ONLY respond to authorized chat
  if [[ "$chat_id" != "$TELEGRAM_CHAT_ID" ]]; then
    echo "[$(date)] Unauthorized chat_id: $chat_id (ignored)"
    echo "{\"last_update_id\": $update_id}" > "$STATE_FILE"
    continue
  fi

  cmd=$(echo "$text" | awk '{print tolower($1)}')
  echo "[$(date)] Command: $cmd"

  case "$cmd" in

    /status)
      account=$(bash "$SCRIPTS/alpaca.sh" account 2>/dev/null || echo '{}')
      equity=$(echo "$account" | jq -r '.equity // "?"')
      cash=$(echo "$account" | jq -r '.cash // "?"')
      daytrade=$(echo "$account" | jq -r '.daytrade_count // "?"')

      positions=$(bash "$SCRIPTS/alpaca.sh" positions 2>/dev/null || echo '[]')
      pos_count=$(echo "$positions" | jq 'length')

      msg="📊 STATUS"
      msg+=$'\n\n'
      msg+="Alpaca equity: \$${equity}"$'\n'
      msg+="Cash: \$${cash}"$'\n'
      msg+="Daytrades: ${daytrade}/3"$'\n'
      msg+="Open positions: ${pos_count}/5"

      if [[ "$pos_count" -gt 0 ]]; then
        msg+=$'\n\n'
        msg+="POSICIONES:"$'\n'
        pos_lines=$(echo "$positions" | jq -r '.[] | "• \(.symbol): \(.qty) sh | P&L: \(.unrealized_pl)$ (\(.unrealized_plpc | tonumber * 100 | floor)%)"')
        msg+="$pos_lines"
      fi

      # Pause state
      if [[ -f "$BOT_STATE" ]] && grep -q "^PAUSED: yes" "$BOT_STATE"; then
        msg+=$'\n\n⏸ Bot PAUSADO (no abre nuevos trades)'
      else
        msg+=$'\n\n▶ Bot ACTIVO'
      fi

      reply "$msg"
      ;;

    /positions)
      positions=$(bash "$SCRIPTS/alpaca.sh" positions 2>/dev/null || echo '[]')
      pos_count=$(echo "$positions" | jq 'length')

      if [[ "$pos_count" -eq 0 ]]; then
        reply "📋 No hay posiciones abiertas."
      else
        msg="📋 POSICIONES ABIERTAS ($pos_count)"$'\n'
        pos_detail=$(echo "$positions" | jq -r '.[] | "\n\(.symbol) — \(.qty) sh\n  Entry: \(.avg_entry_price)$ → Now: \(.current_price)$\n  P&L: \(.unrealized_pl)$ (\(.unrealized_plpc | tonumber * 100 | floor)%)"')
        msg+="$pos_detail"
        reply "$msg"
      fi
      ;;

    /pause)
      mkdir -p "$ROOT/memory"
      cat > "$BOT_STATE" <<EOF
# Bot State

PAUSED: yes
PAUSED_AT: $(date '+%Y-%m-%d %H:%M:%S')
PAUSED_BY: telegram_user

When PAUSED, the bot does NOT open new positions.
Existing positions are still managed normally (stops, exits, midday cuts).
To resume: send /resume from Telegram.
EOF
      reply "⏸ Bot PAUSADO

No se abrirán nuevas posiciones.
Las existentes siguen gestionándose normalmente (stops, exits, etc).

Para reactivar: /resume"
      ;;

    /resume)
      mkdir -p "$ROOT/memory"
      cat > "$BOT_STATE" <<EOF
# Bot State

PAUSED: no
RESUMED_AT: $(date '+%Y-%m-%d %H:%M:%S')

Bot is active. New positions can be opened by market-open routine.
EOF
      reply "▶ Bot REACTIVADO

Volverá a abrir nuevas posiciones en la próxima routine de market-open (15:30 Madrid)."
      ;;

    /closeall)
      reply "🚨 Cerrando TODAS las posiciones..."
      bash "$SCRIPTS/alpaca.sh" cancel-all > /dev/null 2>&1 || true
      bash "$SCRIPTS/alpaca.sh" close-all > /dev/null 2>&1 || true
      sleep 3
      reply "✅ Cierre solicitado. Verifica con /status en unos segundos."
      ;;

    /cancelall)
      bash "$SCRIPTS/alpaca.sh" cancel-all > /dev/null 2>&1 || true
      reply "🚫 Canceladas todas las órdenes pendientes."
      ;;

    /help|/start)
      reply "🤖 COMANDOS DEL BOT

/status — Estado completo (equity, posiciones, pausa)
/positions — Detalle de posiciones abiertas
/pause — Pausar nuevas inversiones
/resume — Reactivar inversiones
/closeall — 🚨 Cerrar TODAS las posiciones (emergencia)
/cancelall — Cancelar órdenes pendientes
/help — Esta ayuda

Las posiciones existentes siempre se gestionan (stops, exits) aunque el bot esté pausado.
Solo /closeall las cierra a la fuerza."
      ;;

    *)
      reply "❓ Comando no reconocido: '$cmd'

Usa /help para ver comandos disponibles."
      ;;
  esac

  # Save processed update_id after each command (avoid re-execution if script restarts mid-loop)
  echo "{\"last_update_id\": $update_id}" > "$STATE_FILE"
done

echo "[$(date)] Done. Last update_id: $(jq -r '.last_update_id' "$STATE_FILE")"
