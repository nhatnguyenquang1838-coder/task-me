import test from "node:test";
import assert from "node:assert/strict";
import { once } from "node:events";
import { InMemoryWorkItemRepository } from "../src/repository/inMemoryWorkItemRepository.js";
import { WorkItemService } from "../src/service/workItemService.js";
import { createHttpServer } from "../src/http/server.js";

test("HTTP API creates and lists work items", async (t) => {
  const service = new WorkItemService(new InMemoryWorkItemRepository());
  const server = createHttpServer(service);
  server.listen(0, "127.0.0.1");
  await once(server, "listening");
  t.after(() => server.close());

  const address = server.address();
  const baseUrl = `http://127.0.0.1:${address.port}`;
  const createdResponse = await fetch(`${baseUrl}/work-items`, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({ id: "W-HTTP", title: "Exercise HTTP flow" }),
  });
  assert.equal(createdResponse.status, 201);

  const listedResponse = await fetch(`${baseUrl}/work-items`);
  assert.equal(listedResponse.status, 200);
  const body = await listedResponse.json();
  assert.equal(body.items.length, 1);
  assert.equal(body.items[0].id, "W-HTTP");
});
