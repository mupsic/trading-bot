---
description: Midday position monitor local. Corta perdedores (-7%), ajusta trailing stops
---

# Midday Monitor (Local)

Ejecuta el flujo midday usando `.env` local. Sin git push.

## Flujo

Sigue **exactamente** `routines/midday.md`, sin la sección de git push.

Pasos clave:
- Pull positions y orders
- Drawdown circuit breaker (si portfolio -10% del peak → alerta + flag)
- Cut losers: cualquier posición con unrealized_plpc ≤ -0.07 → close + cancel stop + log
- Tighten trailing stops:
  - Posición a +20%: trailing 5%
  - Posición a +15%: trailing 7%
  - Nunca acercar a <3% del precio actual
  - Nunca bajar un stop
- Thesis check intraday: cortar si noticias rompen la tesis
- Optional WebSearch si algo se mueve >5% sin causa obvia
- Telegram SOLO si acción tomada
- Update memory/TRADE-LOG.md

## Importante

- **Hard stop -7% es no-negociable**
- Cancelar la orden de stop ANTES de re-colocar una más apretada
