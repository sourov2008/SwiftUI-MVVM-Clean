# SwiftUI MVVM Clean Architecture

![Swift](https://img.shields.io/badge/Swift-5-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-15%2B-blue.svg)

Welcome 👋  
This project shows **how to build a scalable, testable, and easy-to-maintain SwiftUI app** using the **MVVM + Clean Architecture** approach.

It’s written in **simple language and a clear folder structure**, so beginners can learn how to organize bigger SwiftUI projects the right way.

---

## 🧠 Why This Project

Many SwiftUI tutorials stop at “MVVM”, but when your app grows, things can get messy.  
**Clean Architecture** helps you split your code into layers — each with a single job.

This means:
- ✅ Easier to test  
- ✅ Easier to replace a part without breaking others  
- ✅ Easier to add new features  

---

## 🏗️ Project Structure (recommended)

```
SwiftUI-MVVM-Clean
│
├── Domain               // Domain layer should be completely independent of frameworks and third-party libraries; even small utility ones.
│   │                       Prohibited: like Alamofire, Moya, Combine, Realm, CoreData, SwiftUI, UIKit....
│   ├── Entities         // Core data models used across the app
│   ├── UseCases         // Business rules (pure Swift)
│   └── Repositories     // Protocols that describe data access
│
├── Data
│   ├── Remote           // API / networking / mock data
│   ├── Local            // Local DB or UserDefaults (if used)
│   └── RepositoryImpl   // Classes that implement Repository protocols
│
├── Presentation
│   ├── ViewModels       // Handles data for SwiftUI views
│   └── Views            // SwiftUI screens & components
│
├── App
│   ├── DI               // Dependency Injection container / factories
│   └── SwiftUIMVVMCleanApp.swift  // Entry point
│
└── Tests
    ├── DomainTests
    ├── DataTests
    └── PresentationTests
```

Each folder has a clear purpose — this makes the app **easy to navigate and scale**.

> Tip: If your current repo layout is different, you can still follow the same layer ideas.

---

## 📸 How Data Flows (Runtime Data Flow)

```
View → ViewModel → UseCase → Repository → API/LocalData
↑                                               ↓
└───────────── Updates UI with new data ────────┘
```

**Explanation:**
1. The **View** asks the **ViewModel** to do something (e.g., load users).  
2. The **ViewModel** calls a **UseCase** to run the business logic.  
3. The **UseCase** uses a **Repository**, which fetches data (API or local).  
4. Data flows back up and the View updates automatically.

---

## ⚙️ Dependency Injection (DI)

All parts are connected using **protocols**.  
At app start, the **DI Container** decides which real or mock implementation to use.

**Example:**

```swift
let userRepo = UserRepositoryImpl(apiService: ApiService())
let getUserUseCase = GetUserUseCase(repository: userRepo)
let viewModel = UserViewModel(useCase: getUserUseCase)
```

This makes it easy to swap components (e.g., use a mock repository in tests).

---

## 🧩 Example Feature: “Users List” (concept)

| Layer | What it does |
|------|---------------|
| `Entity` | Defines a `User` model. |
| `Repository` | Declares `fetchUsers()` protocol. |
| `RepositoryImpl` | Calls an API to get users. |
| `UseCase` | Uses the repository to get data for the ViewModel. |
| `ViewModel` | Calls the use case and exposes state for the View. |
| `View` | Displays the list of users in SwiftUI. |

**Simple → Clean → Testable.**

---

## 🧪 Testing (quick sample)

Because every part uses protocols, you can test easily:

```swift
class MockUserRepository: UserRepository {
    func fetchUsers() async throws -> [User] {
        [User(id: 1, name: "Test User")]
    }
}

func testUserUseCase() async throws {
    let mockRepo = MockUserRepository()
    let useCase = GetUserUseCase(repository: mockRepo)
    let users = try await useCase.execute()
    XCTAssertEqual(users.first?.name, "Test User")
}
```

✅ No real API  
✅ Fast & reliable tests

---

## 🧰 Tools Used

- **SwiftUI** for UI  
- **Combine / async-await** for async updates  
- **Swift Testing** for unit tests  

---

## 🚀 How to Run

1. Clone the repo  
   ```bash
   git clone https://github.com/sourov2008/SwiftUI-MVVM-Clean.git
   ```
2. Open `SwiftUIMVVMClean.xcodeproj` in Xcode  
3. Press **Run ▶️**

---

## 🪄 Add Your Own Feature (Checklist)

Want to extend the app? Follow these simple steps 👇

1. **Create an Entity**
   ```swift
   struct Product: Identifiable {
       let id: Int
       let name: String
   }
   ```

2. **Define a Repository Protocol**
   ```swift
   protocol ProductRepository {
       func fetchProducts() async throws -> [Product]
   }
   ```

3. **Implement the Repository**
   ```swift
   final class ProductRepositoryImpl: ProductRepository {
       func fetchProducts() async throws -> [Product] {
           // Call API or return mock data
           return [Product(id: 1, name: "Sample")]
       }
   }
   ```

4. **Add a UseCase**
   ```swift
   final class GetProductsUseCase {
       private let repository: ProductRepository
       init(repository: ProductRepository) { self.repository = repository }
       func execute() async throws -> [Product] {
           try await repository.fetchProducts()
       }
   }
   ```

5. **Create a ViewModel**
   ```swift
   @MainActor
   final class ProductViewModel: ObservableObject {
       @Published var products: [Product] = []
       private let useCase: GetProductsUseCase

       init(useCase: GetProductsUseCase) { self.useCase = useCase }

       func loadProducts() async {
           do { products = try await useCase.execute() }
           catch { print(error) }
       }
   }
   ```

6. **Add a View**
   ```swift
   struct ProductListView: View {
       @StateObject var viewModel: ProductViewModel
       var body: some View {
           List(viewModel.products) { product in
               Text(product.name)
           }
           .task { await viewModel.loadProducts() }
       }
   }
   ```

Now you’ve added a full new feature — clean and testable 🎯

---


## 🤖 AI Assistance

This project was created by **Sourob Datta** with support from **AI tools (ChatGPT)** to organize structure, documentation, and examples.  
The goal was to make Clean Architecture easy to understand for beginners learning SwiftUI + MVVM.

---

## ❤️ Author

**Sourob Datta**  
iOS Developer • WatchOS developer.
sourovsuet@gmail.com
[GitHub Profile](https://github.com/sourov2008)


