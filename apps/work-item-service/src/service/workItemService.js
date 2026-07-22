import { randomUUID } from "node:crypto";
import { createWorkItem, transitionWorkItem } from "../domain/workItem.js";

export class WorkItemService {
  constructor(repository, clock = () => new Date()) {
    this.repository = repository;
    this.clock = clock;
  }

  async create(input) {
    const item = createWorkItem({ ...input, id: input.id ?? randomUUID(), now: this.clock() });
    return this.repository.save(item);
  }

  async transition(id, nextStatus) {
    const current = await this.repository.findById(id);
    if (!current) throw new Error(`work item not found: ${id}`);
    return this.repository.save(transitionWorkItem(current, nextStatus, this.clock()));
  }

  async get(id) {
    return this.repository.findById(id);
  }

  async list() {
    return this.repository.list();
  }
}
