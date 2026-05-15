# Trading Bot — Arquitectura

**Última actualización**: 2026-05-14
**Versión**: Híbrida (bash + Claude opcional)
**Base**: Opus 4.7 Trading Bot Setup Guide (Nate Herk)

---

## Resumen ejecutivo

Bot autónomo de paper trading que opera el mercado NY (Alpaca paper account).

- **Capital operativo**: $3,000 (HARD CAP, enforced por código)
- **Estrategia**: Swing trading, max 3 trades/semana, max 5 posiciones
- **Stops**: 10% trailing → 7% al +15% → 5% al +20%, hard stop -7%
- **Modo**: ejecución automática (Mac despierto durante horas de mercado)

---

## Filosofía de diseño

Tres principios:

1. **Claude solo cuando aporta valor real** — analítica, no para tareas mecánicas
2. **Memoria en archivos versionados** — auditable, rollback con git
3. **Reglas duras como gates** — disciplina enforced programáticamente, no por inteligencia

---

## ¿Cuándo se invoca Claude?

| Routine | Usa IA | Por qué |
|---------|--------|---------|
| Pre-market (L-V 13:00 Madrid) | ✅ Claude (Opus) | Research WebSearch, análisis de catalysts, decisión TRADE/HOLD |
| Market-open (L-V 15:30) | ❌ bash puro | Lee candidatos de pre-market, aplica reglas duras numéricas |
| Midday (L-V 18:00) | ❌ bash puro | Hard stop -7%, tighten trailing — todo numérico |
| Daily-summary (L-V 22:00) | ❌ bash puro | Métricas + formato Telegram |
| Weekly-review (Vie 22:30) | ✅ Claude (Opus) | Análisis patrones semanales, ajustes de estrategia |
| Telegram-listener (cada 60s) | ❌ bash puro | Parser de comandos /pause /status /etc |

**Total Claude/semana**: 6 invocaciones (5 pre-market + 1 weekly). Reducción del 99.5% vs polling continuo.

---

## Estructura de directorios

```
Trading Bot/
├── ARCHITECTURE.md             ← este archivo
├── CLAUDE.md                   ← contexto general (legacy del PDF)
├── README.md
├── SETUP.md
├── .env                        ← API keys (gitignored)
├── env.template
├── .gitignore
│
├── routines/                   ← PROMPTS para Claude (solo 2 activos)
│   ├── pre-market.md          ← USADO por run-ai-routine.sh
│   ├── weekly-review.md       ← USADO por run-ai-routine.sh
│   ├── market-open.md         ← DOCUMENTACIÓN (impl en scripts/market-open.sh)
│   ├── midday.md              ← DOCUMENTACIÓN (impl en scripts/midday.sh)
│   └── daily-summary.md       ← DOCUMENTACIÓN (impl en scripts/daily-summary.sh)
│
├── scripts/
│   │   ─── Wrappers de APIs ───
│   ├── alpaca.sh               ← Alpaca v2 API
│   ├── finnhub.sh              ← Finnhub data
│   ├── telegram.sh             ← Telegram notifications
│   │
│   │   ─── Routines bash ───
│   ├── market-open.sh          ← ejecuta trades de pre-market candidates
│   ├── midday.sh               ← stops + tightening + circuit breaker
│   ├── daily-summary.sh        ← EOD snapshot + telegram
│   ├── telegram-listener.sh    ← polling commands desde Telegram
│   │
│   │   ─── Helpers ───
│   ├── run-ai-routine.sh       ← invoca claude CLI para routines IA
│   ├── pause.sh                ← pausa bot (no abre nuevas posiciones)
│   ├── resume.sh               ← reactiva bot
│   ├── panic.sh                ← 🚨 cancela + cierra todo
│   ├── install-launchd.sh      ← carga las 6 tareas en launchd
│   └── uninstall-launchd.sh    ← descarga todas
│
├── launchd/                    ← Plist files (Plan B trigger)
│   ├── com.tradingbot.premarket.plist
│   ├── com.tradingbot.market-open.plist
│   ├── com.tradingbot.midday.plist
│   ├── com.tradingbot.daily-summary.plist
│   ├── com.tradingbot.weekly-review.plist
│   └── com.tradingbot.telegram-listener.plist
│
├── memory/                     ← Estado persistente
│   ├── PROJECT-CONTEXT.md      ← misión, capital cap, safety rules
│   ├── TRADING-STRATEGY.md     ← reglas operativas
│   ├── TRADE-LOG.md            ← cada trade + EOD snapshots
│   ├── RESEARCH-LOG.md         ← pre-market diaria + JSON candidatos
│   ├── WEEKLY-REVIEW.md        ← reviews semanales
│   ├── BOT-STATE.md            ← runtime flag PAUSED yes/no
│   ├── .telegram-state.json    ← last_update_id del listener
│   ├── .telegram-webhook-cleared ← flag de inicio
│   └── .equity-history.jsonl   ← histórico equity diario
│
├── local-commands/             ← Plantillas slash commands (instalar en .claude/commands/)
│
└── logs/                       ← Salida de launchd
    ├── premarket.log
    ├── market-open.log
    └── ...
```

---

## Flujo de un día típico

```
13:00 Madrid (07:00 EDT)
  └── launchd dispara → run-ai-routine.sh pre-market
       └── claude CLI lee routines/pre-market.md
            └── WebSearch (SPY, VIX, catalysts, sectores)
                 └── Identifica 0-3 candidatos
                      └── Escribe RESEARCH-LOG.md con bloque JSON
                           └── Telegram alert solo si urgente

15:30 Madrid (09:30 EDT — apertura NY)
  └── launchd dispara → market-open.sh (bash puro)
       └── Lee BOT-STATE → si PAUSED, exit
            └── Lee RESEARCH-LOG → extrae JSON candidatos
                 └── Para cada candidato: 7 gates de validación
                      └── Ejecuta market buy + trailing stop 10% GTC
                           └── Telegram con trades ejecutados

18:00 Madrid (12:00 EDT — midday)
  └── launchd dispara → midday.sh (bash puro)
       └── Pull positions + orders
            └── Drawdown circuit breaker check (-10% from peak)
                 └── Hard stop check (-7% en cada posición)
                      └── Tighten trailing en winners (+15% → 7%, +20% → 5%)
                           └── Telegram solo si hubo acción

22:00 Madrid (16:00 EDT — cierre NY)
  └── launchd dispara → daily-summary.sh (bash puro)
       └── Pull final account state
            └── Compute operating equity P&L
                 └── Append EOD snapshot a TRADE-LOG.md
                      └── Append a .equity-history.jsonl
                           └── Telegram resumen (siempre)

22:30 Madrid (Viernes 16:30 EDT)
  └── launchd dispara → run-ai-routine.sh weekly-review
       └── claude CLI lee routines/weekly-review.md
            └── Analiza semana completa
                 └── Append a WEEKLY-REVIEW.md con grade
                      └── Ajusta TRADING-STRATEGY.md si justifica
                           └── Telegram con headline numbers

Cada 60 segundos (24/7):
  └── launchd → telegram-listener.sh (bash puro, 0 IA)
       └── Si llega /status, /pause, /closeall, etc → ejecuta y responde
```

---

## Control bidireccional desde Telegram

| Comando | Acción |
|---------|--------|
| `/status` | Snapshot de cuenta + posiciones + estado pause |
| `/positions` | Detalle posiciones |
| `/pause` | Bot deja de abrir nuevas (existentes siguen gestionándose) |
| `/resume` | Reactiva |
| `/closeall` | 🚨 cierra TODAS las posiciones a mercado |
| `/cancelall` | Cancela órdenes pendientes |
| `/help` | Lista de comandos |

Solo responde al `TELEGRAM_CHAT_ID` configurado en `.env` (autorización por chat ID).

---

## Compatibilidad Cowork ↔ launchd

La lógica vive en `scripts/` y `routines/`. Los triggers son intercambiables:

**Plan A (Cowork scheduled tasks) — cuando se resuelva el 403:**
- Crear tasks que invoquen `bash scripts/market-open.sh` etc.
- Para AI: prompt que diga "Lee routines/pre-market.md y ejecuta"

**Plan B (launchd local) — ACTIVO actualmente:**
- `bash scripts/install-launchd.sh` carga las 6 tareas
- Cada plist apunta a su script correspondiente

Cambiar entre planes es trivial: descargar uno, cargar el otro. La lógica no cambia.

---

## Setup desde cero

### 1. Pre-requisitos
- Mac con macOS (para launchd)
- Cuenta Alpaca paper (https://alpaca.markets)
- Cuenta Finnhub free (https://finnhub.io)
- Bot de Telegram creado (BotFather)
- (Opcional pero recomendado) Claude Code CLI: `curl -fsSL https://claude.ai/install.sh | bash`

### 2. Configuración

Editar `.env` con tus credenciales:
```
ALPACA_API_KEY=PK...
ALPACA_API_SECRET=...
ALPACA_BASE_URL=https://paper-api.alpaca.markets
FINNHUB_API_KEY=...
TELEGRAM_BOT_TOKEN=...
TELEGRAM_CHAT_ID=...
OPERATING_CAPITAL=3000
```

### 3. Instalación

```bash
cd "/Users/Ander/Documents/Claude/Projects/Trading Bot"

# Test inicial
bash scripts/telegram.sh test
bash scripts/alpaca.sh account

# Instalar launchd agents
bash scripts/install-launchd.sh
```

### 4. Verificación

- Los 6 agents aparecen en `launchctl list | grep tradingbot`
- Telegram debería recibir mensaje "Bot Test"
- Logs en `logs/` se actualizan tras cada ejecución

---

## Mac despierto

⚠️ **Para que el bot funcione, tu Mac debe estar despierto** durante:
- L-V 13:00, 15:30, 18:00, 22:00 Madrid
- Viernes 22:30 Madrid
- Continuamente (cada minuto) para el listener Telegram

Si tu Mac está apagado o dormido a esas horas, esa routine se pierde.

**Recomendaciones:**
- Configurar "No dormir" en Battery → Schedule en horas de mercado
- Si Mac va a estar apagado mucho: considerar Plan C (GitHub Actions, requiere setup adicional)
- Mantener Mac enchufado durante horas de mercado

---

## Modificar el bot

### Cambiar capital operativo
Editar `OPERATING_CAPITAL=3000` en `.env`. Todas las reglas se recalculan automáticamente.

### Cambiar horario de routines
Editar las plist files en `launchd/`, luego `bash scripts/install-launchd.sh` (idempotente).

### Pausar temporalmente
```bash
bash scripts/pause.sh    # ahora
# o /pause desde Telegram
```

### Salir corriendo (emergencia)
```bash
bash scripts/panic.sh    # cierra todo y pausa
# o /closeall desde Telegram
```

### Desinstalar todo
```bash
bash scripts/uninstall-launchd.sh
```
(El código y los datos quedan intactos — solo se desactivan los triggers.)

---

## Seguridad

- `.env` está en `.gitignore` — las API keys nunca se pushean
- Alpaca está en **paper trading** (URL `paper-api.alpaca.markets`)
- API key empieza por `PK` (paper keys), las keys live empiezan por `AK`
- El cap de $3,000 está enforced en 3 capas: `.env`, `market-open.sh` gates, `position cost <= $600`
- Telegram listener solo acepta comandos del `TELEGRAM_CHAT_ID` autorizado

---

## Troubleshooting

**Los logs en `logs/` no se actualizan:**
- ¿Mac está despierto a la hora?
- `launchctl list | grep tradingbot` muestra los agents?
- Permisos: `chmod +x scripts/*.sh`

**Telegram no recibe mensajes:**
- `bash scripts/telegram.sh test` desde terminal funciona?
- Si sí: revisa `logs/telegram-listener.error.log`
- Si no: re-verificar `TELEGRAM_BOT_TOKEN` y `TELEGRAM_CHAT_ID` en `.env`

**Bot no abre trades aunque hay candidatos:**
- ¿`memory/BOT-STATE.md` dice `PAUSED: yes`? → `bash scripts/resume.sh`
- ¿`memory/TRADING-STRATEGY.md` tiene `NO_NEW_TRADES_UNTIL`? → drawdown breaker disparado
- Revisar `logs/market-open.log` para ver qué gate falló

**Las trades se ejecutan en dinero real:**
- Esto NO debería pasar. Verifica `ALPACA_BASE_URL=https://paper-api.alpaca.markets` en `.env`
- Verifica que `ALPACA_API_KEY` empieza por `PK` (no `AK`)
