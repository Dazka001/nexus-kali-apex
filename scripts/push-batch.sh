#!/usr/bin/env bash
# Uso: ./scripts/push-batch.sh <número_batch> [mensaje_extra]
set -euo pipefail

BATCH="${1:?Uso: $0 <número_batch> [mensaje]}"
MSG="${2:-}"
BRANCH="feat/batch-$(printf '%02d' "$BATCH")"

BATCH_FMT=$(printf '%02d' "$BATCH")

git checkout -b "$BRANCH" 2>/dev/null || git checkout "$BRANCH"
git add -A

COMMIT_MSG="feat(batch-${BATCH_FMT}): Wave implementation"
[[ -n "$MSG" ]] && COMMIT_MSG="${COMMIT_MSG} — ${MSG}"

git commit -m "$COMMIT_MSG"
git push -u origin "$BRANCH"

printf '\n\033[0;32m[✓] Branch %s pusheado — crea PR en GitHub\033[0m\n' "$BRANCH"
