#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
mkdir -p "$HOME/.kiro/agents" "$HOME/.kiro/skills"
[ -d "$ROOT/vendor/understand-anything/.git" ] || "$ROOT/scripts/fetch-ua.sh"

link_skill() {
  local source="$1" name="$2" target="$HOME/.kiro/skills/$name"
  rm -rf "$target"
  ln -s "$source" "$target"
  printf 'linked skill: %s -> %s\n' "$target" "$source"
}

link_skill "$ROOT/vendor/understand-anything/understand-anything-plugin/skills/understand" "understand"
link_skill "$ROOT/vendor/understand-anything/understand-anything-plugin/skills/understand-chat" "understand-chat"
link_skill "$ROOT/vendor/understand-anything/understand-anything-plugin/skills/understand-dashboard" "understand-dashboard"
link_skill "$ROOT/vendor/understand-anything/understand-anything-plugin/skills/understand-diff" "understand-diff"
link_skill "$ROOT/.kiro/skills/implementation-task-architect" "implementation-task-architect"
link_skill "$ROOT/.kiro/skills/ua-project-knowledge" "ua-project-knowledge"

python3 - "$ROOT" <<'PY2'
import json, sys
from pathlib import Path
root=Path(sys.argv[1])
agents=root/'vendor/understand-anything/understand-anything-plugin/agents'
ua={
 'name':'ua-project-knowledge',
 'description':'Build and maintain the canonical Understand Anything graph for the current repository',
 'prompt':f'file://{root}/docs/agents/UA_AGENT.md',
 'tools':['read','write','shell','grep','glob','code','subagent'],
 'resources':[f'file://{p}' for p in sorted(agents.glob('*.md'))],
}
ta={
 'name':'implementation-task-architect',
 'description':'Generate evidence-backed implementation tasks from UA knowledge, requirements and design',
 'prompt':f'file://{root}/docs/agents/TASK_ARCHITECT_AGENT.md',
 'tools':['read','write','shell','grep','glob','code'],
 'resources':[f'file://{root}/.kiro/skills/implementation-task-architect/SKILL.md'],
}
for name,obj in [('ua-project-knowledge',ua),('implementation-task-architect',ta)]:
 p=Path.home()/'.kiro/agents'/f'{name}.json'; p.write_text(json.dumps(obj,indent=2)+'\n')
 print('wrote agent:',p)
PY2

echo 'Kiro setup complete. Restart Kiro IDE.'
