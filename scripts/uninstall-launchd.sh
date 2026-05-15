#!/usr/bin/env bash
# ============================================
# UNINSTALL LAUNCHD AGENTS
# ============================================
# Descarga y elimina las 6 tareas de launchd.
# El bot deja de correr automáticamente.
# No borra código ni configuración — solo desinstala los triggers.
# ============================================

set -euo pipefail

LAUNCHD_DEST="$HOME/Library/LaunchAgents"

echo "=========================================="
echo "Uninstalling Trading Bot launchd agents"
echo "=========================================="
echo ""

PLISTS=(
  "com.tradingbot.premarket.plist"
  "com.tradingbot.market-open.plist"
  "com.tradingbot.midday.plist"
  "com.tradingbot.daily-summary.plist"
  "com.tradingbot.weekly-review.plist"
  "com.tradingbot.telegram-listener.plist"
)

for plist in "${PLISTS[@]}"; do
  DEST="$LAUNCHD_DEST/$plist"
  LABEL="${plist%.plist}"

  if [[ -f "$DEST" ]]; then
    launchctl unload "$DEST" 2>/dev/null || true
    rm -f "$DEST"
    echo "✓ $LABEL desinstalado"
  else
    echo "  $LABEL no estaba instalado"
  fi
done

echo ""
echo "=========================================="
echo "Verificación final"
echo "=========================================="
REMAINING=$(launchctl list | grep "com.tradingbot" || true)
if [[ -z "$REMAINING" ]]; then
  echo "✓ Ningún agent del bot activo. Desinstalación completa."
else
  echo "⚠️  Aún activos:"
  echo "$REMAINING"
fi

echo ""
echo "Para reinstalar: bash scripts/install-launchd.sh"
