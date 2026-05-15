#!/usr/bin/env bash
# Pausa el bot: no abrirá nuevas posiciones.
# Las existentes siguen gestionándose normalmente (stops, exits).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cat > "$ROOT/memory/BOT-STATE.md" <<EOF
# Bot State

PAUSED: yes
PAUSED_AT: $(date '+%Y-%m-%d %H:%M:%S')
PAUSED_BY: terminal

When PAUSED, the bot does NOT open new positions.
Existing positions are still managed normally (stops, exits, midday cuts).
To resume: bash scripts/resume.sh  OR  send /resume from Telegram
EOF

echo "⏸ Bot pausado. No abrirá nuevas posiciones."
bash "$ROOT/scripts/telegram.sh" send "⏸ Bot PAUSADO desde terminal. Posiciones existentes siguen gestionándose." > /dev/null 2>&1 || true
