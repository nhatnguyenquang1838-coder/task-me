#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$ROOT"

node --test apps/work-item-service/test/*.test.js
python3 .kiro/skills/implementation-task-architect/scripts/validate_config.py
python3 tools/knowledge/validate_knowledge_store.py
python3 .kiro/skills/implementation-task-architect/scripts/validate_output_layout.py .ua/generated/task-plans/demo-sla-plan

# Dashboard integration invariants.
[ ! -d apps/ua-homepage ] || { echo 'ERROR: unused UA marketing homepage still exists'; exit 2; }
PUBLIC_GRAPH=vendor/understand-anything/understand-anything-plugin/packages/dashboard/public/knowledge-graph.json
if [ -f "$PUBLIC_GRAPH" ] && ! cmp -s .ua/knowledge-graph.json "$PUBLIC_GRAPH"; then
  echo 'ERROR: dashboard public graph is not the canonical project graph'
  exit 2
fi
[ -f vendor/understand-anything/understand-anything-plugin/packages/dashboard/vite.config.project.ts ] \
  || { echo 'ERROR: project dashboard build config missing'; exit 2; }
grep -Fq 'GRAPH_DIR="$ROOT"' scripts/start-dashboard.sh \
  || { echo 'ERROR: dashboard is not pinned to the repository graph root'; exit 2; }
grep -Fq '.ua/knowledge-graph.json' scripts/start-dashboard.sh \
  || { echo 'ERROR: dashboard graph preflight missing'; exit 2; }

# No unused marketing media or bundled font binaries.
find . -type f \( -iname '*.gif' -o -iname '*.mp4' \) -print -quit | grep -q . \
  && { echo 'ERROR: unused marketing media found'; exit 2; } || true
find . -type f \( -name '*.ttf' -o -name '*.otf' -o -name '*.woff' -o -name '*.woff2' \) -print -quit | grep -q . \
  && { echo 'ERROR: font binary found'; exit 2; } || true

bash -n scripts/*.sh
node --check apps/work-item-service/src/index.js
node --check apps/work-item-service/src/http/server.js
python3 - <<'PYCOMPILE'
from pathlib import Path
for root in (Path('tools'), Path('.kiro/skills/implementation-task-architect/scripts')):
    for path in root.rglob('*.py'):
        compile(path.read_text(encoding='utf-8'), str(path), 'exec')
print('PYTHON_SYNTAX_VALID')
PYCOMPILE

echo 'DASHBOARD_INTEGRATION_VALID'
echo 'PROJECT_VALID'
