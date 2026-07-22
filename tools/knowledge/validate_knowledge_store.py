#!/usr/bin/env python3
from __future__ import annotations

from common import load_json, repo_root


def main() -> None:
    root = repo_root()
    base = load_json(root / ".ua/knowledge-graph.json")
    extension_paths = sorted((root / ".ua/extensions").glob("*.json"))
    extensions = {path: load_json(path, {"nodes": [], "edges": []}) for path in extension_paths}

    errors: list[str] = []
    warnings: list[str] = []
    all_ids: set[str] = set()

    for label, graph in [("base", base), *[(path.name, graph) for path, graph in extensions.items()]]:
        local_ids: set[str] = set()
        for node in graph.get("nodes", []):
            node_id = node.get("id")
            if not node_id:
                errors.append(f"{label}: node missing id")
                continue
            if node_id in local_ids:
                errors.append(f"{label}: duplicate node {node_id}")
            local_ids.add(node_id)
        all_ids.update(local_ids)

    for label, graph in [("base", base), *[(path.name, graph) for path, graph in extensions.items()]]:
        for edge in graph.get("edges", []):
            source = edge.get("source")
            target = edge.get("target")
            if source not in all_ids or target not in all_ids:
                warnings.append(f"{label}: unresolved edge {source} -> {target}")

    for warning in warnings:
        print("WARNING", warning)
    if errors:
        for error in errors:
            print("ERROR", error)
        raise SystemExit(2)

    print(
        "KNOWLEDGE_STORE_VALID "
        f"base_nodes={len(base.get('nodes', []))} "
        f"base_edges={len(base.get('edges', []))} "
        f"extension_graphs={len(extensions)} "
        f"warnings={len(warnings)}"
    )


if __name__ == "__main__":
    main()
