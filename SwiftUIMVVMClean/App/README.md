# App

Thin application layer. Owns lifecycle and high-level composition.

- App.swift: SwiftUI entry point; bootstraps `CompositionRoot` and top navigation.
- AppDelegate.swift: Optional legacy hooks, notifications, background tasks.
- Scene/: `UIScene`/window management, scene delegates if needed.
- Resources/: App icons, launch screen, `.xcassets`, localized resources.
