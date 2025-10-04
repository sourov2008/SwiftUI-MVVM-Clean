
# App

Thin application layer that owns the app lifecycle and high level composition.

This layer is responsible for:
- Configuring dependency injection through the `CompositionRoot`
- Managing app lifecycle and scene setup
- Defining app level resources (icons, mock data, etc.)

### 💡 Notes

- The App layer should not contain business logic — it only wires and launches.
- Keep this layer thin and declarative.
- Use `CompositionRoot` for dependency injection and navigation orchestration.
