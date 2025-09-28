//
//  UsersViewModelIntegrationTests.swift
//  SwiftUIMVVMCleanTests
//
//  Created by Guest Datta on 28.09.25.
//

import Foundation
import Testing
@testable import SwiftUIMVVMClean

@Suite("UsersViewModel integration tests")
@MainActor
struct UsersViewModelIntegrationTests {


    private struct MockUsersRepository: UserRepository {
        let bundle: Bundle
        func fetchUsers() async throws -> [User] {
            return bundle.decode([User].self, from: "MockUsers") ?? []
        }
    }

    private struct ThrowingUsersRepository: UserRepository {
        let error: RepositoryError
        func fetchUsers() async throws -> [User] { throw error }
    }

    // MARK: - Tests

    @Test("Loads users end to end from MockUsers.json")
    func loadsUsersFromJSON() async {
        // Arrange: wire the real use case with a concrete repository backed by the bundle JSON
        let repository = MockUsersRepository(bundle: .main)
        let useCase = FetchUsersUseCase(repository: repository)
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        // Act
        await viewModel.load()

        // Assert
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(!viewModel.users.isEmpty)
    }

    @Test("Presents an error when repository throws")
    func handlesRepositoryError() async {
        // Arrange: simulate a failure path using a valid RepositoryError case
        let repository = ThrowingUsersRepository(error: .offline)
        let useCase = FetchUsersUseCase(repository: repository)
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        // Act
        await viewModel.load()

        // Assert
        #expect(viewModel.isLoading == false)
        #expect(viewModel.users.isEmpty)
        #expect(viewModel.errorMessage == RepositoryError.offline.errorDescription)
    }
}

