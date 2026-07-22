const PRIORITIES = new Set(["low", "medium", "high"]);
const TRANSITIONS = {
  draft: new Set(["ready"]),
  ready: new Set(["in_progress"]),
  in_progress: new Set(["done"]),
  done: new Set(),
};

export function createWorkItem({ id, title, description = "", priority = "medium", now = new Date() }) {
  if (!id || typeof id !== "string") throw new Error("id is required");
  if (!title || typeof title !== "string") throw new Error("title is required");
  if (!PRIORITIES.has(priority)) throw new Error(`unsupported priority: ${priority}`);
  return Object.freeze({
    id,
    title: title.trim(),
    description: description.trim(),
    priority,
    status: "draft",
    createdAt: now.toISOString(),
    updatedAt: now.toISOString(),
  });
}

export function transitionWorkItem(item, nextStatus, now = new Date()) {
  const allowed = TRANSITIONS[item.status];
  if (!allowed || !allowed.has(nextStatus)) {
    throw new Error(`invalid transition: ${item.status} -> ${nextStatus}`);
  }
  return Object.freeze({ ...item, status: nextStatus, updatedAt: now.toISOString() });
}

export function isKnownStatus(status) {
  return Object.hasOwn(TRANSITIONS, status);
}
