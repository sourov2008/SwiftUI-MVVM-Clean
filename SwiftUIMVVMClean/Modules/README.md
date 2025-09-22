# Modules

Primary code area split by responsibilities. Dependency direction: App → CompositionRoot → Features → Domain → Core. Data implements Domain protocols.

- Core/: Cross-cutting utilities (no App/UI dependencies).
- SharedUI/: Design system and reusable SwiftUI components.
- Domain/: Pure business rules (entities, value objects, use cases, repository protocols).
- Data/: External adapters (remote/local sources, mappers, repository implementations).
- Features/: Vertical feature slices (each with Presentation/Domain/Data as needed).
- CompositionRoot/: Dependency graph wiring for live, mock, and preview environments.
