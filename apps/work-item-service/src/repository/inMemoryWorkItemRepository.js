export class InMemoryWorkItemRepository {
  #items = new Map();

  async save(item) {
    this.#items.set(item.id, structuredClone(item));
    return structuredClone(item);
  }

  async findById(id) {
    const item = this.#items.get(id);
    return item ? structuredClone(item) : null;
  }

  async list() {
    return [...this.#items.values()].map((item) => structuredClone(item));
  }
}
