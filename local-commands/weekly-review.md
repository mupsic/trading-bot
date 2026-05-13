---
description: Weekly review local (viernes). Stats, grading, ajustes de estrategia si justifica
---

# Weekly Review (Local)

Ejecuta el flujo weekly review usando `.env` local. Sin git push.

## Flujo

Sigue **exactamente** `routines/weekly-review.md`, sin la sección de git push.

Pasos clave:
- Lee toda la semana de TRADE-LOG y RESEARCH-LOG
- Pull Friday close state
- Compute métricas semanales:
  - Week return $ y %
  - Comparación vs S&P 500 (WebSearch)
  - W/L/open trades
  - Win rate, profit factor
  - Best/worst trade
- Sector analysis: blacklist sectores con 2 pérdidas consecutivas
- Append full review section a memory/WEEKLY-REVIEW.md
- Update TRADING-STRATEGY.md SOLO si cambio justificado (2+ semanas de evidencia)
- Telegram weekly summary SIEMPRE

## Reglas de cambio de strategy

- NO cambiar reglas basándose en datos de 1 semana (ruido)
- Una regla debe fallar 2+ semanas seguidas antes de relajarla
- Una regla debe probar éxito 2+ semanas antes de endurecerla
- Cualquier cambio se documenta con fecha y razón
