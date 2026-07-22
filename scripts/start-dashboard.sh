#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
UA_ROOT="$ROOT/vendor/understand-anything"
[ -d "$UA_ROOT/.git" ] || "$ROOT/scripts/fetch-ua.sh"
CORE_DIST="$UA_ROOT/understand-anything-plugin/packages/core/dist/schema.js"

command -v node >/dev/null || { echo 'ERROR: Node.js 22+ is required.'; exit 2; }
command -v corepack >/dev/null || { echo 'ERROR: corepack is required.'; exit 2; }
[ -f "$ROOT/.ua/knowledge-graph.json" ] || {
  echo 'ERROR: .ua/knowledge-graph.json is missing. Run the UA agent first.'
  exit 2
}
[ -d "$UA_ROOT/node_modules" ] || {
  echo 'ERROR: UA dependencies are not installed.'
  echo 'Run: npm run setup:deps'
  exit 2
}
if [ ! -f "$CORE_DIST" ]; then
  echo '[dashboard] Building @understand-anything/core...'
  (cd "$UA_ROOT" && corepack pnpm --filter @understand-anything/core build)
fi

echo '[dashboard] Loading project graph from:'
echo "  $ROOT/.ua/knowledge-graph.json"
echo '[dashboard] The terminal will print the tokenized localhost URL.'
cd "$UA_ROOT"
GRAPH_DIR="$ROOT" corepack pnpm --filter @understand-anything/dashboard dev
