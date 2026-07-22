# Task Architect Agent

Load `.kiro/skills/implementation-task-architect/SKILL.md` and execute its runbook.

Use `.ua/knowledge-graph.json` as structural knowledge and `.ua/extensions/**` as
canonical planning knowledge. Read `.task-architect/config.json` first.

For every implementation task, create exactly one folder under:

`.ua/generated/task-plans/<run-id>/tasks/<task-id>-<slug>/`

Never modify product code. Never use MCP. Verify every named path and symbol
against the repository before including it in a coding guide.
