# UA Project Graph + Task Architect for Kiro

A compact Kiro-ready project with one maintained repository knowledge store:

- **Understand Anything Agent** builds and refreshes `.ua/knowledge-graph.json`.
- **UA Graph Dashboard** uses the upstream UA graph UI and loads this project's graph.
- **Task Architect Agent** enriches `.ua/extensions/` and generates one folder per implementation task.
- **Work Item Service** is a small Node.js sample with requirements, design, architecture and tests.
- **UA runtime and dashboard source** are vendored under `vendor/understand-anything/`.

The separate UA marketing homepage and its large GIF/PNG demonstration assets
have been removed. They are not required to analyze or display this project.

## First setup

```bash
./scripts/bootstrap.sh --install-deps
```

Restart Kiro after the bootstrap so the workspace agents are discovered.

## Open the project graph

```bash
npm start
```

This starts the real UA graph dashboard on `127.0.0.1:5173`. The terminal prints
a tokenized URL such as:

```text
http://127.0.0.1:5173/?token=<generated-token>
```

The dashboard reads:

```text
.ua/knowledge-graph.json
.ua/domain-graph.json       # optional
.ua/diff-overlay.json       # optional
.ua/meta.json
.ua/config.json
```

It does not load the bundled UA demo graph.

## Commands

```bash
npm start                         # UA dashboard, loads root .ua project graph
npm run dashboard:build           # static dashboard build with synced project graph
npm run dashboard:preview         # preview the static build
npm run api:start                 # sample API on port 3000
npm test                          # sample service tests
npm run check                     # validate app, knowledge store and task folders
npm run ua:query -- WorkItem      # query base + extension knowledge
```

## Kiro agents

1. `ua-project-knowledge` — analyze or refresh the canonical `.ua` graph.
2. `implementation-task-architect` — plan a feature using UA knowledge and approved documents.

Suggested prompts:

```text
Analyze this project and refresh the canonical UA knowledge store.
```

```text
Create an implementation plan for FEAT-SLA-001 using the UA graph and all approved design documents.
```

## Important paths

```text
.kiro/agents/                    Kiro agent definitions
.kiro/skills/                    UA wrapper and Task Architect skill
.ua/                             single canonical knowledge root
apps/work-item-service/          sample product
vendor/understand-anything/      UA analyzer and graph dashboard
scripts/start-dashboard.sh       connects UA UI to root .ua graph
```

Read `docs/QUICKSTART.md` and `docs/knowledge/ONE-KNOWLEDGE-STORE.md` next.
