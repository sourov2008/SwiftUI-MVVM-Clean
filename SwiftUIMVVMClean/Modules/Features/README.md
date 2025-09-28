# Features

Vertical slices, each owning its MVVM stack and optional domain/data.

- <Feature>/Presentation/: SwiftUI Views, ViewModels, and Navigation.
- <Feature>/Domain/: Feature-specific use cases (optional; depend on shared Domain).
- <Feature>/Data/: Feature-specific data (optional) if isolation is desired.

Example: User, Onboarding, Accounts.
