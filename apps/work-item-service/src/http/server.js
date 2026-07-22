import { createServer } from "node:http";

async function readJson(request) {
  const chunks = [];
  for await (const chunk of request) chunks.push(chunk);
  if (chunks.length === 0) return {};
  return JSON.parse(Buffer.concat(chunks).toString("utf8"));
}

function send(response, status, body) {
  response.writeHead(status, { "content-type": "application/json; charset=utf-8" });
  response.end(JSON.stringify(body));
}

export function createHttpServer(service) {
  return createServer(async (request, response) => {
    try {
      const url = new URL(request.url, "http://localhost");
      if (request.method === "GET" && url.pathname === "/health") {
        return send(response, 200, { status: "ok" });
      }
      if (request.method === "GET" && url.pathname === "/work-items") {
        return send(response, 200, { items: await service.list() });
      }
      if (request.method === "POST" && url.pathname === "/work-items") {
        return send(response, 201, await service.create(await readJson(request)));
      }
      const transitionMatch = url.pathname.match(/^\/work-items\/([^/]+)\/transitions$/);
      if (request.method === "POST" && transitionMatch) {
        const body = await readJson(request);
        return send(response, 200, await service.transition(transitionMatch[1], body.status));
      }
      return send(response, 404, { error: "not_found" });
    } catch (error) {
      return send(response, 400, { error: error instanceof Error ? error.message : String(error) });
    }
  });
}
