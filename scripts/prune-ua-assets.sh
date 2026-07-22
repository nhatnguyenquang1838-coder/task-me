#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
UA="$ROOT/vendor/understand-anything"

# Keep analyzer, skills, core and graph dashboard. Remove only presentation/demo data.
rm -rf "$UA/apps/homepage" "$UA/apps/website" 2>/dev/null || true
rm -f "$UA/understand-anything-plugin/packages/dashboard/public/knowledge-graph.json"
find "$UA" -type f \( -iname 'overview-*.gif' -o -iname 'overview-*.png' -o -iname 'hero.jpg' \) -delete 2>/dev/null || true

echo 'UA_UNUSED_ASSETS_PRUNED'
