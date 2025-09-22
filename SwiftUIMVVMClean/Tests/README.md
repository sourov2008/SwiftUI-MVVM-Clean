# Tests

Test targets mirroring modules. Prefer feature-level tests; keep unit tests close to the unit under test.

- CoreTests/: Utilities and foundation code tests.
- DomainTests/: Entities, value objects, use cases.
- DataTests/: Repositories, mappers, sources (use mocks/fakes).
- Features_AccountsTests/: End-to-end and presentation tests for Accounts.
- UITests/: UI automation tests.
