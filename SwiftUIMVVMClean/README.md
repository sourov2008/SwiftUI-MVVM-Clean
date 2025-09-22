# SwiftUIMVVMClean

Describes the project layout. Key folders:

- App: Thin iOS composition layer (app lifecycle, scenes, resources).
- Modules: Source of truth for business code (Core, Domain, Data, SharedUI, Features, CompositionRoot).
- Tests: Test targets mirroring modules.
- Config: Tooling/configuration (linting, codegen, build settings, secrets template).
- Package.swift: SPM manifest for modularization in CI and previews.
