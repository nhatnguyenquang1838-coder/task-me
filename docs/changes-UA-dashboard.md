# UA dashboard integration update

Date: 2026-07-22

## Changed

- `npm start` now launches the upstream UA graph dashboard.
- The dashboard is pinned to the repository root through `GRAPH_DIR`.
- The UI loads `.ua/knowledge-graph.json`, not UA's example graph.
- The sample API moved to `npm run api:start`.
- Added static dashboard build and preview commands.

## Removed

- Mirrored Astro marketing homepage under `apps/ua-homepage`.
- Homepage GIF, PNG and JPG demonstration assets.
- Upstream dashboard example `public/knowledge-graph.json`.
- Google Fonts network requests.

## Retained

- Upstream UA React graph UI.
- Graph layouts, filters, search, node inspection and project overview.
- UA analysis skills, agents, parser support and core graph validation.
- Kiro UA Agent and Task Architect Agent.
