import test from "node:test";
import assert from "node:assert/strict";
import { createWorkItem, transitionWorkItem } from "../src/domain/workItem.js";

test("creates a draft work item", () => {
  const item = createWorkItem({ id: "W-1", title: "Write runbook", priority: "high", now: new Date("2026-07-22T00:00:00Z") });
  assert.equal(item.status, "draft");
  assert.equal(item.priority, "high");
});

test("enforces ordered transitions", () => {
  const item = createWorkItem({ id: "W-1", title: "Write runbook" });
  assert.throws(() => transitionWorkItem(item, "done"), /invalid transition/);
  assert.equal(transitionWorkItem(item, "ready").status, "ready");
});
