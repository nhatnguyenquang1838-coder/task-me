# UA runbook for Kiro

1. Run `./scripts/bootstrap.sh --install-deps` once.
2. Restart Kiro.
3. Select agent `ua-project-knowledge`.
4. Ask: `Analyze this project and refresh the canonical .ua knowledge store.`
5. Review `.ua/knowledge-graph.json` and the agent phase report.
6. Start the upstream dashboard through the UA skill, or inspect the graph with
   `python3 tools/knowledge/query_knowledge.py workItem`.

Incremental refresh uses UA's existing commit/fingerprint behavior. The agent
must preserve Task Architect extensions.
