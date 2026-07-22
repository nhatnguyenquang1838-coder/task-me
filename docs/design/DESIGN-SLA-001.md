# DESIGN-SLA-001 — SLA implementation design

Status: Approved for planning

## DD-SLA-001 — Keep SLA calculation in the domain

Add a pure domain function that derives `slaStatus` from a work item and a supplied clock value. Do not persist `slaStatus`; persist only `dueAt`.

Likely targets:

- `apps/work-item-service/src/domain/workItem.js`
- `apps/work-item-service/src/service/workItemService.js`

## DD-SLA-002 — Repository query remains capability-based

Add `listOverdue(now)` to the repository interface represented by the in-memory implementation. The service selects `list()` or `listOverdue(now)` based on the requested filter.

Likely target:

- `apps/work-item-service/src/repository/inMemoryWorkItemRepository.js`

## DD-SLA-003 — HTTP compatibility

Extend `GET /work-items` with the optional query parameter `filter=overdue`. Unknown filter values return HTTP 400. Existing routes and response envelope `{ items: [...] }` remain unchanged.

Likely target:

- `apps/work-item-service/src/http/server.js`

## Non-goals

- No database migration.
- No background notifications.
- No timezone conversion beyond accepting ISO-8601 timestamps.
- No UI implementation.
