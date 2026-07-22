import test from "node:test";
import assert from "node:assert/strict";
import { InMemoryWorkItemRepository } from "../src/repository/inMemoryWorkItemRepository.js";
import { WorkItemService } from "../src/service/workItemService.js";

test("creates and retrieves a work item", async () => {
  const service = new WorkItemService(new InMemoryWorkItemRepository(), () => new Date("2026-07-22T00:00:00Z"));
  const created = await service.create({ id: "W-2", title: "Analyze impact" });
  assert.deepEqual(await service.get(created.id), created);
});
