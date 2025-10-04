
# Config

Project wide configuration and development tooling.

This folder holds build-time and code-quality configurations that apply globally across all modules.

---

### 🧰 Includes

- **.swiftlint.yml** – Lint rules enforcing style and safety standards.
- **.swiftgen.yml** – Configuration for asset and localization code generation.
- *(Optional)* **.swiftformat**, **.xcconfig**, or CI/CD configs.

---

### 💡 Notes

- These files affect how the project is built, linted, or generated — **not** how it runs.
- Runtime or environment configuration (e.g. `AppConfiguration.swift`, API keys) lives in `Infrastructure/Config/`.
