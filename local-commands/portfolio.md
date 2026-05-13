---
description: Read-only snapshot del portfolio (cuenta, posiciones, órdenes, stops)
---

# Portfolio Snapshot (Read-Only)

No state changes, no orders, no file writes. Solo informa.

## Pasos

1. Ejecuta:
   ```
   bash scripts/alpaca.sh account
   bash scripts/alpaca.sh positions
   bash scripts/alpaca.sh orders
   ```

2. Formatea como resumen único y limpio:

   ```
   📊 Portfolio — <today's date>

   Alpaca equity: $X (reported — puede exceder cap)
   Operating cap: $3,000 (HARD CAP del bot)
   Cash: $X | Buying power: $X
   Daytrade count: N/3 | PDT account: <true/false>

   Open Positions:
     SYM | Sh | Entry → Now | Unrealized $ (P%) | Stop
     ...

   Open Orders:
     TYPE | SYM | qty | trail/stop | order_id
     ...
   ```

3. **Solo añade comentario** si detectas algo roto:
   - Posición sin stop asociado
   - Stop por debajo del precio actual (debería estar arriba en sells)
   - Capital deployed > $3,000 (cap excedido)
   - Daytrade count cerca del límite (>= 2)

Sin embellecimiento. Sin recomendaciones. Solo el estado actual.
