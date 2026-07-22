# Task Architect runbook for Kiro

1. Ensure `.ua/knowledge-graph.json` exists and is fresh enough for planning.
2. Select agent `implementation-task-architect`.
3. Ask: `Create an implementation plan for FEAT-SLA-001.`
4. The agent builds/refreshes spec and traceability extensions.
5. The agent creates one folder for each task plan.
6. Run `./scripts/validate.sh`.
7. Review `task-index.yaml`, `task-dag.mmd`, then each independent task folder.

The generated sample under `.ua/generated/task-plans/demo-sla-plan/` shows the
required output contract.
