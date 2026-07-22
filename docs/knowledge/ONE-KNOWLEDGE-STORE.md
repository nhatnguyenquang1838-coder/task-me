# One knowledge store

`.ua/` is the single logical knowledge root.

- `knowledge-graph.json`: UA structural graph.
- `extensions/spec-graph.json`: requirements, acceptance criteria, designs and ADRs.
- `extensions/traceability-graph.json`: links from documents to UA code nodes.
- `extensions/planning-graph.json`: canonical implementation task nodes and dependencies.
- `generated/task-plans/`: generated per-task views; not canonical knowledge.

Task Architect must update extension graphs first, then materialize task folders.
It must not create a second standalone evidence store.
