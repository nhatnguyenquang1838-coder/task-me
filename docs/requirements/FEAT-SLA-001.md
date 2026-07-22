# FEAT-SLA-001 — Due dates and SLA visibility

Status: Approved for planning

## REQ-SLA-001 — Optional due date

A work item may contain an optional `dueAt` timestamp in ISO-8601 UTC format.
Creation must reject an invalid timestamp or a due date earlier than `createdAt`.
Existing work items without `dueAt` remain valid.

## REQ-SLA-002 — Derived SLA state

API responses must include a derived `slaStatus` with one of:

- `not_configured` when no due date exists;
- `on_track` when the due date is more than 24 hours away;
- `due_soon` when the due date is within 24 hours and not past;
- `overdue` when the current time is after the due date and status is not `done`;
- `completed` when status is `done`.

## REQ-SLA-003 — Overdue query

`GET /work-items?filter=overdue` returns only overdue work items.
The endpoint must continue returning all items when no filter is supplied.

## Acceptance criteria

### AC-SLA-001
Creating a work item with a valid future `dueAt` persists the value unchanged.

### AC-SLA-002
Invalid or past due dates return a validation error without persisting an item.

### AC-SLA-003
The overdue filter excludes completed work items and items without a due date.

### AC-SLA-004
All existing tests remain green and new domain, service, repository and HTTP tests cover the feature.
