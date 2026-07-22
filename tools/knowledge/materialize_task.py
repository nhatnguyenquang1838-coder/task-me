#!/usr/bin/env python3
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

from common import load_json, repo_root

FILES = [
    "task.yaml",
    "README.md",
    "impact-analysis.md",
    "implementation-plan.md",
    "coding-guide.md",
    "test-plan.md",
    "evidence.json",
    "decisions.md",
]


def slugify(value: str) -> str:
    return re.sub(r"[^a-z0-9]+", "-", value.lower()).strip("-")


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: materialize_task.py <run-id> <task.json>")

    root = repo_root()
    run_id = sys.argv[1]
    task = load_json(Path(sys.argv[2]).resolve())
    task_id = task["task_id"]
    folder = (
        root
        / ".ua/generated/task-plans"
        / run_id
        / "tasks"
        / f"{task_id}-{slugify(task['title'])}"
    )
    folder.mkdir(parents=True, exist_ok=False)

    (folder / "task.yaml").write_text(
        "\n".join(
            [
                f"task_id: {task_id}",
                f"title: {task['title']}",
                f"objective: {task['objective']}",
                "",
            ]
        ),
        encoding="utf-8",
    )

    for name in FILES[1:]:
        if name == "evidence.json":
            (folder / name).write_text(
                json.dumps(task.get("evidence", {}), indent=2) + "\n",
                encoding="utf-8",
            )
        else:
            (folder / name).write_text(
                f"# {task['title']}\n\nGenerated placeholder for `{name}`.\n",
                encoding="utf-8",
            )

    print(folder)


if __name__ == "__main__":
    main()
