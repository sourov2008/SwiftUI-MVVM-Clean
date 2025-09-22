# Core

Foundational, cross-cutting code. No dependencies on App, UI, or platform-specific frameworks beyond what is necessary.

- Logging/: Logging abstractions and concrete loggers.
- Networking/: HTTP clients, request builders, interceptors, retry/backoff.
- Persistence/: Keychain, UserDefaults, file storage abstractions.
- Utilities/: Date/UUID helpers, concurrency utilities, result builders.
- CoreExports.swift: Re-exports for ergonomic imports from consumers.
