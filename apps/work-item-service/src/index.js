import { InMemoryWorkItemRepository } from "./repository/inMemoryWorkItemRepository.js";
import { WorkItemService } from "./service/workItemService.js";
import { createHttpServer } from "./http/server.js";

const port = Number(process.env.PORT ?? 3000);
const repository = new InMemoryWorkItemRepository();
const service = new WorkItemService(repository);
const server = createHttpServer(service);
server.listen(port, () => console.log(`work-item-service listening on http://localhost:${port}`));
