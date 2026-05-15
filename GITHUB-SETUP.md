# GitHub Actions Setup — Trading Bot

Guía paso a paso para activar el bot 24/7 en GitHub Actions (sin necesidad de Mac despierto).

---

## Resumen de arquitectura

- **6 workflows automáticos** corren en GitHub Actions runners (cloud, no tu Mac)
- **Pre-market y weekly-review** usan **Anthropic API** (Opus 4.6) con **WebSearch nativo**
- **Market-open, midday, daily-summary, listener** son **bash puro** (no IA)
- **Estado se persiste en el repo Git** — cada workflow hace commit+push de las memory files
- **Comandos Telegram** funcionan vía listener cada 5 minutos (latencia 0-5 min)

---

## Paso 1: Conseguir API key de Anthropic

Vas a necesitar una API key separada (no es la misma que tu suscripción Claude). El uso será mínimo: ~6 invocaciones/semana, costo estimado < $1/mes.

1. Ve a https://console.anthropic.com/
2. Inicia sesión con tu cuenta Anthropic
3. Settings → API Keys → Create Key
4. Copia el key (empieza con `sk-ant-`)
5. Guárdalo, lo usarás en el Paso 3

**Importante**: Tu cuenta API necesita crédito ($5 mínimo para empezar). Para 6 calls/semana con Opus + WebSearch, $5 te durarán meses.

---

## Paso 2: Push del código actualizado al repo

Desde tu Mac, terminal:

```bash
cd "/Users/Ander/Documents/Claude/Projects/Trading Bot"

# Verifica que .env está en .gitignore (NUNCA subas tus API keys)
grep -q "^\.env" .gitignore || echo ".env" >> .gitignore

# Stage los archivos nuevos
git add .github/ scripts/ requirements.txt ARCHITECTURE.md GITHUB-SETUP.md
git add memory/ routines/ launchd/ local-commands/

# Commit
git commit -m "Add GitHub Actions workflows + Anthropic API integration"

# Push a GitHub
git push origin main
```

---

## Paso 3: Configurar GitHub Secrets

En tu navegador, ve a tu repo: `https://github.com/mupsic/trading-bot`

1. Click **Settings** (en la pestaña superior del repo, no del perfil)
2. En el sidebar izquierdo: **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Añade estos secrets uno por uno (copia el valor exactamente de tu `.env` local):

| Name | Valor |
|------|-------|
| `ANTHROPIC_API_KEY` | Tu key del Paso 1 (empieza por `sk-ant-`) |
| `ALPACA_API_KEY` | Del .env (empieza por `PK` para paper) |
| `ALPACA_API_SECRET` | Del .env |
| `FINNHUB_API_KEY` | Del .env |
| `TELEGRAM_BOT_TOKEN` | Del .env |
| `TELEGRAM_CHAT_ID` | Del .env |

⚠️ **NO añadas `OPERATING_CAPITAL`** como secret. Está hardcoded a `"3000"` en los workflows (es solo un número, no un secret).

---

## Paso 4: Hacer el repo público (para minutos ilimitados de Actions)

GitHub Actions tiene 2,000 minutos/mes gratis en repos privados. Con el listener cada 5 minutos + 5 routines diarias, vas a consumir ~3,000-4,000 minutos/mes. Solución:

**Opción A — Hacer el repo público (recomendada, gratis)**:
1. Repo → Settings → General
2. Scroll hasta abajo: "Danger Zone" → **Change visibility** → Make public

Lo público es solo el código (no tus API keys, que están en Secrets). Está seguro.

**Opción B — Mantener privado con GitHub Pro** ($4/mes):
- Te da 3,000 minutos/mes — apenas alcanza
- Tendrías que reducir frecuencia del listener (10-15 min en vez de 5)

**Opción C — Reducir polling del listener**:
- Cambiar cron del listener a cada 15 min: `'*/15 * * * *'`
- Reduce consumo a ~1,500 min/mes — dentro del free tier privado
- Latencia 0-15 min para comandos Telegram

---

## Paso 5: Activar GitHub Actions

1. Repo → Settings → Actions → General
2. Sección "Actions permissions": **Allow all actions and reusable workflows**
3. Sección "Workflow permissions": **Read and write permissions** (para que los workflows puedan hacer push)
4. Marca **Allow GitHub Actions to create and approve pull requests** (no obligatorio pero útil)
5. Click **Save**

---

## Paso 6: Verificar que arranca

Ve a la pestaña **Actions** de tu repo. Verás los 6 workflows listados:

- Pre-Market Research
- Market-Open Execution
- Midday Monitor
- Daily Summary EOD
- Weekly Review
- Telegram Listener

**Prueba manual** (NO esperes al cron):

1. Click en **Telegram Listener** → botón **Run workflow** (en la derecha) → **Run workflow**
2. Se ejecutará en ~10-30 segundos
3. Si todo OK, debería completar sin errores (badge verde ✓)

**Prueba final**: envía `/help` a tu bot en Telegram. En máximo 5 minutos te llegará la respuesta.

---

## Paso 7: Verificar primera ejecución completa

Las routines arrancarán automáticamente según el cron. Para no esperar al día siguiente, puedes dispararlas manualmente desde Actions UI:

- **Pre-Market**: cualquier momento entre lunes-viernes. Generará un RESEARCH-LOG entry.
- **Market-Open**: solo tiene sentido durante horario de mercado NY (15:30-22:00 Madrid L-V)
- **Daily-Summary**: siempre OK ejecutar, te manda un EOD a Telegram
- **Weekly-Review**: solo viernes después del cierre

---

## Cómo desactivar el bot

**Pausa temporal** (no abre nuevos trades, gestiona existentes):
- Envía `/pause` por Telegram
- O edita `memory/BOT-STATE.md` en GitHub web (pon `PAUSED: yes`) y commit

**Desactivar workflows completamente**:
1. Repo → Settings → Actions → General
2. **Disable Actions** → solo el toggle de arriba

**Borrar el bot del todo**:
- En cada workflow individual (Actions → workflow → ... → Disable workflow)
- O simplemente borrar la carpeta `.github/workflows/` y push

---

## ⚠️ DUPLICACIÓN: launchd + GitHub Actions

Recuerda: si tienes el bot ya corriendo en **launchd local** (con `install-launchd.sh`), va a **ejecutar trades duplicados** con GitHub Actions.

**Solución**: desactiva uno de los dos. Probablemente quieres GitHub Actions (cloud, sin Mac).

```bash
# Desactivar launchd local
bash scripts/uninstall-launchd.sh
```

---

## Horarios de las workflows (UTC)

⚠️ GitHub Actions cron usa UTC. Los horarios actuales asumen **EDT** (verano NY). En invierno (EST, noviembre-marzo) necesitarás ajustar +1 hora cada cron expression:

| Workflow | Cron UTC | EDT (verano) | Madrid (verano) |
|----------|----------|--------------|-----------------|
| Pre-market | `0 11 * * 1-5` | 7:00 AM | 13:00 |
| Market-open | `30 13 * * 1-5` | 9:30 AM | 15:30 |
| Midday | `0 16 * * 1-5` | 12:00 PM | 18:00 |
| Daily-summary | `5 20 * * 1-5` | 4:05 PM | 22:05 |
| Weekly-review | `30 20 * * 5` | Vie 4:30 PM | Vie 22:30 |
| Telegram-listener | `*/5 * * * *` | cada 5 min | cada 5 min |

---

## Troubleshooting

**Workflow falla con "secrets undefined"**:
- Verifica que añadiste TODOS los secrets en Settings → Secrets → Actions (Paso 3)

**Workflow falla con "git push permission denied"**:
- Settings → Actions → General → Workflow permissions → "Read and write permissions"

**No me llegan mensajes de Telegram**:
- Run manual del listener desde Actions UI — ¿da error?
- Revisa los logs del run en Actions tab
- Verifica `TELEGRAM_BOT_TOKEN` y `TELEGRAM_CHAT_ID` en Secrets

**Anthropic API falla con "credit balance too low"**:
- Console Anthropic → Billing → Add credit ($5 mínimo)

**Trades duplicados**:
- Tienes launchd Y GitHub Actions corriendo al mismo tiempo
- Desactiva uno: `bash scripts/uninstall-launchd.sh`

**Las routines no ejecutan en hora correcta**:
- Verifica que estamos en EDT (verano). En EST tienes que ajustar +1 hora los crons
- Edita los `.yml` y haz push

---

## Costos esperados

- **GitHub Actions**: $0 (repo público = gratis ilimitado)
- **Anthropic API**: ~$0.50-2/mes con Opus 4.6 + WebSearch para 6 calls/semana
- **Alpaca paper**: $0 (paper trading es gratis)
- **Finnhub**: $0 (free tier)
- **Telegram bot**: $0

**Total estimado**: <$2/mes una vez en marcha.

---

## Resumen rápido

```
Paso 1: ANTHROPIC_API_KEY desde console.anthropic.com
Paso 2: git push del código actualizado
Paso 3: Añadir 6 GitHub Secrets
Paso 4: Repo público (o GitHub Pro)
Paso 5: Activar Actions con write permissions
Paso 6: Run manual del Telegram Listener para validar
Paso 7: Desactivar launchd local (evitar duplicados)
```

Si algo falla en cualquier paso, mira la pestaña Actions del repo — los logs detallados están ahí.
