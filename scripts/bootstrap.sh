#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
MODE="${1:---skip-deps}"
cd "$ROOT"
./scripts/fetch-ua.sh
./scripts/install-kiro-agents.sh
if [ "$MODE" = "--install-deps" ]; then ./scripts/install-dependencies.sh; fi
python3 tools/knowledge/build_spec_graph.py
python3 tools/knowledge/build_indexes.py
./scripts/validate.sh
echo 'Bootstrap complete.'
