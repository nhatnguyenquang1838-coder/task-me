# UA dashboard integration

## Goal

Use the upstream Understand Anything dashboard presentation without showing UA's
sample repository graph or its marketing homepage.

## Development path

```text
npm start
  -> scripts/start-dashboard.sh
  -> GRAPH_DIR=<repository root>
  -> upstream UA dashboard Vite server
  -> <repository>/.ua/knowledge-graph.json
```

The upstream `vite.config.ts` provides protected local endpoints for the graph,
metadata, optional domain graph, diff overlay, freshness report and source file
preview. The server binds to `127.0.0.1` and prints a one-time tokenized URL.

## Static build path

```text
npm run dashboard:build
  -> scripts/sync-dashboard-data.sh
  -> copy canonical .ua files into dashboard/public
  -> vite.config.project.ts
  -> static dashboard dist
```

Static builds display the graph but do not expose the development server's
protected source-file preview endpoint.

## Removed resources

- `apps/ua-homepage/`
- `overview-structural.gif`
- `overview-domain.gif`
- `overview.png`
- upstream dashboard demo `public/knowledge-graph.json`
- Google Fonts network requests

These resources are unrelated to the analyzed project and are not needed by UA
analysis, graph maintenance or Task Architect.

## Retained UA components

- UA skills and specialist agents
- core graph types and validation
- structural and non-code parsers
- incremental graph workflow
- dashboard React source and layout algorithms
- dashboard icons required by the application
