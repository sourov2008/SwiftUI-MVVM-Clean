# SwiftUIMVVMClean

Describes the project layout. Key folders:

- App: Thin iOS composition layer (app lifecycle, scenes, resources).
- Config: Tooling/configuration (linting, codegen, build settings, ci/cd).
- Features: Different types of features like User, Payment, Purchase. Will have their individual Presentation, Data, Domain Folders.
- Infrastructure: shared by all over app. Like networking, persistence, analytics
- Tests: Test targets mirroring modules.


⚙️ Framework & Library Guidelines

You should primarily add frameworks and third-party libraries only in the outermost layers of the architecture:

✅ Infrastructure layer → The Infrastructure layer is where your app talks to the outside world. networking, persistence, analytics (e.g. Alamofire, Realm, Firebase)
✅ Presentation layer → UI frameworks (e.g. SwiftUI, Combine)
🚫 Domain layer → should always remain pure Swift, no external dependencies.
