#!/usr/bin/env bash
# 🚨 BOTÓN DE PÁNICO: cancela TODAS las órdenes pendientes y cierra TODAS las posiciones.
# Sin confirmación — uso de emergencia.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPTS="$ROOT/scripts"

echo "🚨 PANIC: cancelando órdenes y cerrando posiciones..."

bash "$SCRIPTS/telegram.sh" alert CRITICAL "🚨 PANIC ACTIVADO desde terminal: cancelando órdenes y cerrando todas las posiciones..." > /dev/null 2>&1 || true

# Cancelar todas las órdenes pendientes
bash "$SCRIPTS/alpaca.sh" cancel-all 2>&1 || echo "(no había órdenes pendientes)"

# Cerrar todas las posiciones a mercado
bash "$SCRIPTS/alpaca.sh" close-all 2>&1 || echo "(no había posiciones abiertas)"

# Pausar el bot para que no abra nuevas
cat > "$ROOT/memory/BOT-STATE.md" <<EOF
# Bot State

PAUSED: yes
PAUSED_AT: $(date '+%Y-%m-%d %H:%M:%S')
PAUSED_BY: panic_script

Bot was put into PANIC state.
All positions and orders were force-closed.
To resume operations: bash scripts/resume.sh
EOF

sleep 3
bash "$SCRIPTS/telegram.sh" alert CRITICAL "✅ Panic completado. Bot pausado. Verifica con bash scripts/alpaca.sh positions" > /dev/null 2>&1 || true

echo "✅ Panic completado. Bot pausado."
echo "   Verifica con: bash scripts/alpaca.sh positions"
echo "   Reanuda con: bash scripts/resume.sh"
