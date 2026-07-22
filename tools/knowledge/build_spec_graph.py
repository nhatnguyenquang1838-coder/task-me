#!/usr/bin/env python3
from __future__ import annotations

import glob
import hashlib
import re
from pathlib import Path

from common import load_json, repo_root, save_json

ID_RE = re.compile(r"^(FEAT|REQ|AC|DD|ADR)-[A-Z0-9-]+")
KIND = {
    "FEAT": "Feature",
    "REQ": "Requirement",
    "AC": "AcceptanceCriterion",
    "DD": "DesignDecision",
    "ADR": "ArchitectureDecision",
}


def main() -> None:
    root = repo_root()
    cfg = load_json(root / ".task-architect/config.json")
    paths: list[Path] = []
    for group in ("requirements", "design", "system_graph"):
        for pattern in cfg["sources"].get(group, []):
            paths.extend(Path(p) for p in glob.glob(str(root / pattern), recursive=True))

    nodes: list[dict] = []
    edges: list[dict] = []
    for path in sorted(set(p for p in paths if p.is_file())):
        rel = path.relative_to(root).as_posix()
        content = path.read_text(encoding="utf-8", errors="replace")
        doc_id = f"document:{rel}"
        nodes.append(
            {
                "id": doc_id,
                "type": "Document",
                "title": path.name,
                "path": rel,
                "contentHash": hashlib.sha256(content.encode()).hexdigest(),
            }
        )

        feature_id: str | None = None
        for line_no, line in enumerate(content.splitlines(), 1):
            if not line.startswith("#"):
                continue
            title = line.lstrip("#").strip()
            match = ID_RE.match(title)
            if not match:
                continue
            entity_id = title.split("—", 1)[0].strip().split(" ", 1)[0]
            kind = KIND[match.group(1)]
            node_id = f"{kind.lower()}:{entity_id}"
            nodes.append(
                {
                    "id": node_id,
                    "type": kind,
                    "title": title,
                    "path": rel,
                    "line": line_no,
                }
            )
            edges.append(
                {
                    "source": doc_id,
                    "target": node_id,
                    "type": "CONTAINS",
                    "confidence": 1.0,
                }
            )
            if kind == "Feature":
                feature_id = node_id
            elif feature_id:
                edges.append(
                    {
                        "source": feature_id,
                        "target": node_id,
                        "type": "DECOMPOSES_TO",
                        "confidence": 1.0,
                    }
                )

    save_json(
        root / ".ua/extensions/spec-graph.json",
        {
            "version": "1.0.0",
            "kind": "spec-extension",
            "nodes": nodes,
            "edges": edges,
        },
    )
    print(f"SPEC_GRAPH_BUILT nodes={len(nodes)} edges={len(edges)}")


if __name__ == "__main__":
    main()
