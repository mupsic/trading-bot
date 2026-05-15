#!/usr/bin/env bash
# ============================================
# INSTALL LAUNCHD AGENTS
# ============================================
# Instala las 6 tareas de launchd para correr el bot automáticamente.
# Copia los .plist a ~/Library/LaunchAgents/ y los carga con launchctl.
# ============================================

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LAUNCHD_SRC="$ROOT/launchd"
LAUNCHD_DEST="$HOME/Library/LaunchAgents"
LOGS_DIR="$ROOT/logs"

echo "=========================================="
echo "Installing Trading Bot launchd agents"
echo "=========================================="
echo ""

# Crear directorios necesarios
mkdir -p "$LAUNCHD_DEST"
mkdir -p "$LOGS_DIR"

# Asegurar permisos de ejecución en todos los scripts
chmod +x "$ROOT/scripts/"*.sh
echo "✓ Permisos de ejecución asignados a scripts/*.sh"

# Verificar claude CLI (warning si no está, pero seguimos)
if ! command -v claude &> /dev/null; then
  echo ""
  echo "⚠️  WARNING: claude CLI no encontrado."
  echo "   pre-market y weekly-review NO funcionarán hasta que lo instales:"
  echo "   curl -fsSL https://claude.ai/install.sh | bash"
  echo ""
fi

# Lista de plists a instalar
PLISTS=(
  "com.tradingbot.premarket.plist"
  "com.tradingbot.market-open.plist"
  "com.tradingbot.midday.plist"
  "com.tradingbot.daily-summary.plist"
  "com.tradingbot.weekly-review.plist"
  "com.tradingbot.telegram-listener.plist"
)

# Instalar cada plist
for plist in "${PLISTS[@]}"; do
  SRC="$LAUNCHD_SRC/$plist"
  DEST="$LAUNCHD_DEST/$plist"
  LABEL="${plist%.plist}"

  if [[ ! -f "$SRC" ]]; then
    echo "✗ $plist NOT FOUND in $LAUNCHD_SRC"
    continue
  fi

  # Descargar si ya estaba cargado (idempotente)
  launchctl unload "$DEST" 2>/dev/null || true

  # Copiar
  cp "$SRC" "$DEST"

  # Cargar
  if launchctl load "$DEST" 2>/dev/null; then
    echo "✓ $LABEL cargado"
  else
    echo "✗ Error cargando $LABEL"
  fi
done

echo ""
echo "=========================================="
echo "Verificación: estado actual de los agents"
echo "=========================================="
launchctl list | grep "com.tradingbot" || echo "(ninguno cargado — revisa errores arriba)"

echo ""
echo "Logs disponibles en: $LOGS_DIR"
echo ""
echo "Para desinstalar todo: bash scripts/uninstall-launchd.sh"
echo "Para parar el bot:     bash scripts/pause.sh"
echo "Botón de pánico:       bash scripts/panic.sh"
