# Coding guide

- Preserve immutable domain objects.
- Inject time rather than reading the clock inside pure domain functions.
- Keep the `{ items: [...] }` HTTP response envelope.
- Do not add external runtime dependencies or a database.
