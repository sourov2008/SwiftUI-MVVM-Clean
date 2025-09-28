# Data: Shared

Implements the `Domain` abstractions by talking to the outside world.

- Sources/Remote/: API clients, DTOs, endpoints.
- Sources/Local/: Disk, Keychain, CoreData/SQLite adapters.
- Mappers/: DTO ↔ Entity transformations.
- RepositoriesImpl/: Concrete repo conformances to `Domain` protocols.
- DataExports.swift: Re-exports.
