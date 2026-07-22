#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
UA_ROOT="$ROOT/vendor/understand-anything"
[ -d "$UA_ROOT/.git" ] || "$ROOT/scripts/fetch-ua.sh"

command -v node >/dev/null || { echo 'Node.js 22+ is required'; exit 2; }
MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
[ "$MAJOR" -ge 22 ] || { echo 'Node.js 22+ is required'; exit 2; }
command -v corepack >/dev/null || { echo 'corepack is required'; exit 2; }

corepack enable
corepack prepare pnpm@10.6.2 --activate
corepack pnpm --dir "$UA_ROOT" install --frozen-lockfile \
  || corepack pnpm --dir "$UA_ROOT" install --no-frozen-lockfile
(
  cd "$UA_ROOT"
  corepack pnpm --filter @understand-anything/core build
)
echo 'UA_DEPENDENCIES_READY'
