#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
PUBLIC="$ROOT/vendor/understand-anything/understand-anything-plugin/packages/dashboard/public"
UA="$ROOT/.ua"

[ -f "$UA/knowledge-graph.json" ] || {
  echo 'ERROR: .ua/knowledge-graph.json is missing.'
  exit 2
}
mkdir -p "$PUBLIC"

# Remove stale generated data before syncing the canonical project data.
rm -f \
  "$PUBLIC/knowledge-graph.json" \
  "$PUBLIC/domain-graph.json" \
  "$PUBLIC/diff-overlay.json" \
  "$PUBLIC/meta.json" \
  "$PUBLIC/config.json" \
  "$PUBLIC/staleness.json"

cp "$UA/knowledge-graph.json" "$PUBLIC/knowledge-graph.json"
for name in domain-graph.json diff-overlay.json meta.json config.json staleness.json; do
  [ -f "$UA/$name" ] && cp "$UA/$name" "$PUBLIC/$name"
done

echo "DASHBOARD_DATA_SYNCED $PUBLIC"
