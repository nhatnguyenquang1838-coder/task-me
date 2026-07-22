# TASK-003 — Expose overdue HTTP filter and SLA response state

Extend GET /work-items with filter=overdue and include derived slaStatus in API responses.

## Primary targets
- `apps/work-item-service/src/http/server.js`
