---
description: Market open execution local (versión sin git push)
---

# Market Open Execution (Local)

Ejecuta el flujo de market open usando el `.env` local. Sin git push.

## Flujo

Sigue **exactamente** `routines/market-open.md`, con estas diferencias:

1. Saltar verificación de env cloud-style.
2. Saltar STEP 9 (commit + push) — modo local.

Resto idéntico:
- Read memory + check today's RESEARCH-LOG
- Si decisión = HOLD → STOP, no trades
- Re-validate quotes via Alpaca + Finnhub
- Check halts y spreads
- Compute capital available (vs $3,000 cap)
- Buy-side GATE (todos los checks)
- Execute approved buys (market orders, day TIF)
- Place trailing stop 10% GTC inmediatamente
- Si stop falla → fallback a fixed stop → si también falla → CLOSE inmediato
- Log trades + skips a TRADE-LOG
- Telegram notification SOLO si trades ejecutados

## Importante

- **Modo ejecución automática** — el bot ejecuta órdenes reales en Alpaca paper
- Nunca dejes una posición sin stop. Si no puedes ponerle stop, ciérrala
