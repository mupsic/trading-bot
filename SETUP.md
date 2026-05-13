# 🚀 SETUP CHECKLIST

Completa estos pasos para que el bot esté listo para usar.

---

## ✅ PASO 1: Configura el `.env`

En VS Code, abre tu archivo `.env` y rellena **TODOS** estos valores:

```
# ALPACA
ALPACA_API_KEY=PK5N6A7F32CY36TCR5JTXPFLP6
ALPACA_API_SECRET=gEFfQm1xJfniwHmzaejH9ismsxxSG1RhScZtv8RyqfD
ALPACA_BASE_URL=https://paper-api.alpaca.markets/v2

# NEWSAPI (Financial News)
NEWSAPI_API_KEY=832ce57dd60c4ad697a69d67a69bed13

# CLICKUP
CLICKUP_API_TOKEN=pk_296657128_LW04IPFT7NMNG9KBZRI6BJUK4B5A6399
CLICKUP_WORKSPACE_ID=90171224571
CLICKUP_CHAT_ID=90175623496
```

**Guarda el archivo (Cmd + S)**

---

## ✅ PASO 2: Haz los Scripts Ejecutables

En Terminal, ejecuta:

```bash
cd ~/Projects/trading-bot

chmod +x scripts/alpaca.sh
chmod +x scripts/perplexity.sh
chmod +x scripts/clickup.sh
chmod +x scripts/news.sh
```

---

## ✅ PASO 3: Prueba Alpaca

```bash
./scripts/alpaca.sh account
```

Deberías ver tu información de cuenta (capital, buying power, etc.)

**Si falla:** Verifica tu API KEY y SECRET en `.env`

---

## ✅ PASO 4: Prueba NewsAPI

```bash
./scripts/news.sh market
```

Deberías ver noticias financieras del mercado.

**Si falla:** Verifica tu NewsAPI key en `.env`

---

## ✅ PASO 5: Prueba ClickUp

```bash
./scripts/clickup.sh send "Bot initialized successfully"
```

Deberías ver el mensaje llegar a tu chat de ClickUp.

**Si falla:** Verifica tu token, workspace ID y chat ID en `.env`

---

## ✅ PASO 6: Prueba un Trade (Paper Trading)

Esto es una **prueba de concepto**, no un trade real:

```bash
./scripts/alpaca.sh buy AAPL 1 market
```

Deberías ver una orden ejecutada (1 acción de AAPL).

Para cerrar la posición:

```bash
./scripts/alpaca.sh close AAPL
```

---

## ✅ PASO 7: Revisa los Archivos de Memoria

Abre en VS Code:

- `memory/TRADING-STRATEGY.md` - Revisa las reglas
- `memory/TRADE-LOG.md` - Donde se registran los trades
- `memory/RESEARCH-LOG.md` - Donde va el research
- `memory/WEEKLY-REVIEW.md` - Performance semanal

---

## ✅ PASO 8: Haz una Prueba Manual Completa

Ejecuta esto en orden:

```bash
# 1. Research
./scripts/news.sh market

# 2. Revisar cuenta
./scripts/alpaca.sh account

# 3. Ver posiciones abiertas
./scripts/alpaca.sh positions

# 4. Enviar notificación
./scripts/clickup.sh send "Morning routine complete"
```

---

## 🎯 SIGUIENTE: Integración con Claude Code (Opcional)

Una vez todo funciona, puedes:

1. Instalar **Claude Code** en tu Mac
2. Configurar **5 rutinas automáticas** (7am, 9:30am, 12pm, 4pm, viernes 4pm)
3. Cada rutina ejecutará los scripts automáticamente

Pero **por ahora,** puedes ejecutar los scripts manualmente.

---

## ⚠️ TROUBLESHOOTING

### "Permission denied" al ejecutar script
```bash
chmod +x scripts/alpaca.sh
chmod +x scripts/news.sh
chmod +x scripts/clickup.sh
```

### "API key invalid"
- Verifica que los valores en `.env` sean exactos (sin espacios extra)
- Asegúrate de haber copiado las keys completamente

### "Cannot find .env"
- Asegúrate que `.env` está en la **raíz** de `trading-bot/`
- No debería estar dentro de `scripts/` ni `memory/`

### Script funciona pero no ve .env
```bash
cd ~/Projects/trading-bot
source .env
echo $ALPACA_API_KEY  # Debería mostrar tu key
```

---

## ✅ CUANDO TODO FUNCIONA

**¡Felicidades!** Tu bot está listo. Ahora puedes:

1. **Paper Trade:** Practica con dinero simulado
2. **Monitorear:** Revisa los logs en `logs/`
3. **Ajustar:** Modifica TRADING-STRATEGY.md según los resultados
4. **Automatizar:** Configura routinas en Claude Code

---

**¿Dónde estás? ¿Qué paso completaste?**
