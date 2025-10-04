# Infrastructure: Shared

Framework-dependent services and technical implementations used by multiple layers.
Handles communication with the outside world and provides reusable utilities.

Networking/: Low-level HTTP transport and request execution (NetworkClient, URLSessionNetworkClient, Endpoint).

Persistence/: Local storage, caching, and file management (FileStorageService, UserDefaultsStore).

Security/: Secure data handling (KeychainService, SecureStore).

Logging/: Centralized logging and analytics (Logger, AnalyticsService).

Config/: Environment-specific setup, base URLs, and API keys (AppConfiguration, Environment).

All components here are framework aware, but business logic free.
They are used by the Data layer and wired together in AppComposition.
