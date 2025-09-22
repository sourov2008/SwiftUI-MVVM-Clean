# Domain

Pure business rules. No platform or UI dependencies.

- Entities/: Core domain models (value semantics, Codable where useful).
- ValueObjects/: Validated, immutable types encapsulating invariants.
- Repositories/: Protocols defining data access boundaries.
- UseCases/: Interactors orchestrating business operations (protocol + impl).
- Errors/: Domain-specific error types.
- DomainExports.swift: Re-exports for consumer convenience.
