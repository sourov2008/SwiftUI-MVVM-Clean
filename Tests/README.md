# Tests

Test targets mirroring modules. Prefer feature-level tests; keep unit tests close to the unit under test.

- CoreTests/: Utilities and foundation code tests.
- DomainTests/: Entities, value objects, use cases.
- DataTests/: Repositories, mappers, sources (use mocks/fakes).
- UITests/: UI automation tests.

MVVM + Clean, the Domain layer (Use Cases, Entities) and the Presentation layer (ViewModels) are the highest priority for unit testing.
