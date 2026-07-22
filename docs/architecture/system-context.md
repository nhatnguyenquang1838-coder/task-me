# System context

```mermaid
flowchart LR
  Client[HTTP client] --> Server[Node HTTP adapter]
  Server --> Service[WorkItemService]
  Service --> Domain[Work item domain rules]
  Service --> Repo[In-memory repository]
  Docs[Requirements and design] --> TA[Task Architect]
  UA[Understand Anything] --> KG[.ua canonical knowledge store]
  KG --> TA
  TA --> Plans[Per-task plan folders]
```

## Runtime boundaries

- The HTTP adapter translates requests and errors.
- The service coordinates domain and repository behavior.
- Domain functions are pure and clock-injectable.
- The repository owns storage and query operations.
