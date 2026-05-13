# Local Slash Commands

Estos archivos son **plantillas** para los slash commands locales de Claude Code.

## Instalación

El directorio `.claude/` está protegido y no puedo escribirlo directamente desde Claude.
Para activar estos comandos como slash commands locales, copia los archivos a `.claude/commands/`:

```bash
mkdir -p .claude/commands
cp local-commands/*.md .claude/commands/
```

Después de copiarlos, podrás usarlos en Claude Code escribiendo:

- `/portfolio` — snapshot read-only de tu cuenta
- `/trade SYMBOL SHARES buy` — trade manual con validación
- `/pre-market` — research diaria
- `/market-open` — ejecución apertura
- `/midday` — monitor intradía
- `/daily-summary` — EOD snapshot
- `/weekly-review` — revisión viernes

## Diferencia con routines/

- `local-commands/` (estos) → uso manual desde tu Claude Code local, no hace git push
- `routines/` → pegar verbatim en Claude Code cloud routines, automatización 24/7, sí hace git push

Las routines son la **versión de producción** del bot. Los slash commands locales son para testing y intervención manual.
