#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
UA_ROOT="$ROOT/vendor/understand-anything"
[ -d "$UA_ROOT/.git" ] || "$ROOT/scripts/fetch-ua.sh"
DASHBOARD="$UA_ROOT/understand-anything-plugin/packages/dashboard"

[ -d "$UA_ROOT/node_modules" ] || {
  echo 'ERROR: UA dependencies are not installed.'
  echo 'Run: npm run setup:deps'
  exit 2
}
cleanup() { "$ROOT/scripts/clean-dashboard-data.sh" >/dev/null; }
trap cleanup EXIT

"$ROOT/scripts/sync-dashboard-data.sh"
(
  cd "$UA_ROOT"
  corepack pnpm --filter @understand-anything/core build
  corepack pnpm --filter @understand-anything/dashboard exec vite build --config vite.config.project.ts
)
echo "DASHBOARD_BUILT $DASHBOARD/dist"
