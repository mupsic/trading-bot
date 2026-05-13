---
description: Pre-market research local (versión sin git push). Mismo flujo que routine cloud
---

# Pre-Market Research (Local)

Ejecuta el flujo de pre-market research usando el `.env` local. **No requiere git commit/push** (modo local).

## Flujo

Sigue **exactamente** los pasos del prompt en `routines/pre-market.md`, con estas diferencias:

1. **Saltar verificación de env vars cloud-style** — el `.env` local se carga automáticamente por los scripts.
2. **Saltar STEP 8 (commit + push)** — no es necesario en modo local.

Resto del flujo idéntico:
- Lee memory files
- Pull Alpaca state
- Pull Finnhub data
- Market regime check (SPY > MA200, VIX < 25) via WebSearch
- Identifica 2-3 candidatos con todos los filtros
- Calcula sizing sobre $3,000 (HARD CAP)
- Escribe entry en `memory/RESEARCH-LOG.md`
- Telegram alert SOLO si urgente

## Recordatorios

- OPERATING_CAPITAL = $3,000 (no usar nunca más, aunque Alpaca tenga $100k)
- Max $600 por posición (20%)
- Catalyst obligatorio para CADA candidato
- Si Regime OFF → decisión HOLD
