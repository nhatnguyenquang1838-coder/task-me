# ADR-001 — In-memory repository for the starter

Status: Accepted

The starter uses `InMemoryWorkItemRepository` to keep runtime dependencies at zero.
The repository boundary is retained so a persistent adapter can be introduced later.
Task plans must not introduce a database for FEAT-SLA-001.
