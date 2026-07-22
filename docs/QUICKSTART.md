# Quick start

## Prerequisites

- macOS or Linux
- Node.js 22+
- Python 3.11+
- Kiro IDE or Kiro CLI

## 1. Bootstrap

```bash
./scripts/bootstrap.sh --install-deps
```

Use `--skip-deps` only for no-network validation of the included graph and task
plan. The interactive dashboard requires the UA JavaScript dependencies.

## 2. View this project's graph

```bash
npm start
```

Open the tokenized URL printed by the terminal. `GRAPH_DIR` is fixed to the
repository root by `scripts/start-dashboard.sh`, so the dashboard loads:

```text
<repository>/.ua/knowledge-graph.json
```

The upstream dashboard's example `public/knowledge-graph.json` is intentionally
removed to prevent it from masking the project graph.

## 3. Refresh the graph in Kiro

Select `ua-project-knowledge` and send:

```text
Analyze this project and refresh the canonical UA knowledge store.
```

Refresh the browser after the agent updates `.ua/knowledge-graph.json`.

## 4. Generate task plans

Select `implementation-task-architect` and send:

```text
Create an implementation plan for FEAT-SLA-001 using the UA graph and all approved design documents.
```

Generated folders appear under:

```text
.ua/generated/task-plans/<run-id>/tasks/<TASK-ID>-<slug>/
```

## Optional sample API

```bash
npm run api:start
curl http://localhost:3000/health
```

The API is separate from the graph dashboard.

## Static dashboard

```bash
npm run dashboard:build
npm run dashboard:preview
```

The build command copies the current canonical `.ua` files into the dashboard
public build input. Run it again after refreshing the graph.
