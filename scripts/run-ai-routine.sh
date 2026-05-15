#!/usr/bin/env bash
# ============================================
# RUN AI ROUTINE
# ============================================
# Invoca claude CLI con el prompt de una routine markdown.
# Usado por launchd para pre-market y weekly-review (las únicas que necesitan IA).
#
# Usage:
#   bash scripts/run-ai-routine.sh pre-market
#   bash scripts/run-ai-routine.sh weekly-review
# ============================================

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ROUTINE_NAME="${1:?usage: run-ai-routine.sh ROUTINE_NAME}"
ROUTINE_FILE="$ROOT/routines/${ROUTINE_NAME}.md"

if [[ ! -f "$ROUTINE_FILE" ]]; then
  echo "[ERROR] Routine file not found: $ROUTINE_FILE" >&2
  bash "$ROOT/scripts/telegram.sh" alert CRITICAL "Routine '$ROUTINE_NAME' file missing" > /dev/null 2>&1 || true
  exit 1
fi

# Verify claude CLI is available
if ! command -v claude &> /dev/null; then
  echo "[ERROR] claude CLI not found. Install: curl -fsSL https://claude.ai/install.sh | bash" >&2
  bash "$ROOT/scripts/telegram.sh" alert CRITICAL "Claude CLI no instalado. Routine '$ROUTINE_NAME' no puede ejecutarse." > /dev/null 2>&1 || true
  exit 1
fi

# Extract the inner prompt block from the routine markdown
# The routines wrap the actual prompt inside ``` blocks
PROMPT=$(python3 <<PYEOF
import re
with open("$ROUTINE_FILE") as f:
    text = f.read()
# Match content between first ```\n and matching ```
m = re.search(r'^\`\`\`\s*\n(.*?)\n\`\`\`\s*$', text, re.MULTILINE | re.DOTALL)
if m:
    print(m.group(1))
else:
    # Fallback: send full file
    print(text)
PYEOF
)

# Add a final instruction reminding Claude to act NOW (not just describe what to do)
FULL_PROMPT="${PROMPT}

---
EXECUTE the workflow now. Read files, run wrappers, take actions, send Telegram. Do not just describe what you would do — DO it. When complete, exit."

# Log start
TS=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TS] Starting AI routine: $ROUTINE_NAME"

# Run claude in print/non-interactive mode
# We pipe the prompt as stdin and use --print to get one-shot output
# --dangerously-skip-permissions allows bash/file operations without per-tool approval
echo "$FULL_PROMPT" | claude --print --dangerously-skip-permissions 2>&1 || {
  EXIT_CODE=$?
  bash "$ROOT/scripts/telegram.sh" alert CRITICAL "Routine '$ROUTINE_NAME' falló con exit code $EXIT_CODE" > /dev/null 2>&1 || true
  exit $EXIT_CODE
}

echo "[$(date '+%Y-%m-%d %H:%M:%S')] AI routine $ROUTINE_NAME completed"
