#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
PUBLIC="$ROOT/vendor/understand-anything/understand-anything-plugin/packages/dashboard/public"
rm -f \
  "$PUBLIC/knowledge-graph.json" \
  "$PUBLIC/domain-graph.json" \
  "$PUBLIC/diff-overlay.json" \
  "$PUBLIC/meta.json" \
  "$PUBLIC/config.json" \
  "$PUBLIC/staleness.json"
echo 'DASHBOARD_GENERATED_DATA_CLEANED'
