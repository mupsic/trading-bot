#!/usr/bin/env bash
# Reactiva el bot: volverá a abrir nuevas posiciones en la próxima routine.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cat > "$ROOT/memory/BOT-STATE.md" <<EOF
# Bot State

PAUSED: no
RESUMED_AT: $(date '+%Y-%m-%d %H:%M:%S')

Bot is active. New positions can be opened by market-open routine.
EOF

echo "▶ Bot reactivado."
bash "$ROOT/scripts/telegram.sh" send "▶ Bot REACTIVADO desde terminal. Volverá a abrir nuevas posiciones en la próxima routine de market-open." > /dev/null 2>&1 || true
