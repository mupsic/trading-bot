---
description: Helper manual para colocar trade con validación completa. Uso — /trade SYMBOL SHARES buy|sell
---

# Manual Trade Helper

Ejecuta un trade manual con TODA la validación de reglas del bot. Refusa si alguna regla falla.

## Args

`SYMBOL SHARES SIDE` (buy o sell). Si faltan, pregunta.

## Pasos

1. **Pull state**:
   ```
   bash scripts/alpaca.sh account
   bash scripts/alpaca.sh positions
   bash scripts/alpaca.sh quote SYMBOL
   bash scripts/alpaca.sh operating-capital
   ```

2. **For BUY, validate todos los gates**:
   - Total positions after fill <= 5
   - Trades this week + 1 <= 3 (count from TRADE-LOG Mon-today)
   - SHARES × P <= $600 (20% del cap $3,000)
   - (Current positions value + SHARES × P) <= $3,000 (cap enforcement)
   - SHARES × P <= available cash en Alpaca
   - daytrade_count < 3 (PDT awareness)
   - Catalyst documented en RESEARCH-LOG de hoy

   Si CUALQUIER check falla: STOP, imprime los checks fallidos, NO ejecuta.

3. **For SELL**: confirma que la posición existe con la qty correcta.

4. **Print order JSON + validation results**, pregunta: ¿Ejecutar? (y/n)

5. **Solo on "y"**, ejecuta:
   ```
   bash scripts/alpaca.sh buy SYMBOL SHARES market
   ```

6. **Para BUYs**, inmediatamente coloca trailing stop:
   ```
   bash scripts/alpaca.sh trailing-stop SYMBOL SHARES 10
   ```

7. **Log to memory/TRADE-LOG.md** con thesis, entry, stop, target, R:R.

8. **Notifica via Telegram**:
   ```
   bash scripts/telegram.sh trade BUY SYMBOL SHARES PRICE "manual — thesis"
   ```

## Importante

- Si pides forzar un trade que viola reglas, refusa firmemente
- Nunca ejecutes sin "y" explícito
- El cap de $3,000 NO se rompe, ni manualmente
