# Modules

Primary code area split by responsibilities. Dependency direction: App → CompositionRoot → Features → Domain → Core. Data implements Domain protocols.

- Core/: Shared: Cross-cutting utilities (no App/UI dependencies).
- SharedUI/: Shared: Design system and reusable SwiftUI components.
- Domain/:Shared: Pure business rules (entities, value objects, use cases, repository protocols).
- Data/:Shared: External adapters (remote/local sources, mappers, repository implementations).
- Features/: Vertical feature slices (each with Presentation/Domain/Data as needed).
