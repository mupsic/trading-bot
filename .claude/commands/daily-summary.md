---
description: EOD summary local. Calcula P&L día/fase, snapshot, Telegram siempre
---

# Daily Summary EOD (Local)

Ejecuta el flujo EOD usando `.env` local. Sin git push.

## Flujo

Sigue **exactamente** `routines/daily-summary.md`, sin la sección de git push.

Pasos clave:
- Pull Alpaca state final del día
- Compute métricas:
  - Operating equity = min($3000, alpaca_equity)
  - Day P&L vs yesterday's operating equity
  - Phase P&L vs $3,000 starting
  - Peak equity y drawdown
  - Trades today y this week
- Drawdown circuit breaker re-check (si > -10% → flag a TRADING-STRATEGY)
- Append EOD snapshot a memory/TRADE-LOG.md
- Telegram daily summary **SIEMPRE** (incluso días sin trades, máx 15 líneas)

## Importante

- El snapshot EOD es la base del cálculo P&L de mañana — no saltarlo nunca
- Operating equity SIEMPRE está capada a $3,000 para las métricas del bot
