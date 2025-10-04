//
//  UsersViewModelTests.swift
//  SwiftUIMVVMCleanTests
//
//  Created by Guest Datta on 28.09.25.
//

import Foundation
import Testing
@testable import SwiftUIMVVMClean

// MARK: - Test Doubles
private struct MockFetchUsersUseCase: FetchUsersUseCaseProtocol {
    enum Mode {
        case success([User])
        case failure(Error)
    }

    var mode: Mode

    init(mode: Mode) {
        self.mode = mode
    }

    func execute() async throws -> [User] {
        switch mode {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
}

private enum TestError: Error, LocalizedError { case boom
    var errorDescription: String? { "Boom" }
}

// MARK: - Tests
@Suite("UsersViewModel unit tests")
@MainActor
struct UsersViewModelTests {

    @Test("Initial state is empty and not loading")
    func initialState() async throws {
        let useCase = MockFetchUsersUseCase(mode: .success([]))
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        #expect(viewModel.users.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    @Test("Successful load sets users and stops loading")
    func loadSuccess() async throws {
        let expected: [User] = Bundle.main.decode([User].self, from: "MockUsers") ?? []
        let useCase = MockFetchUsersUseCase(mode: .success(expected))
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        await viewModel.load()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.users == expected)
    }

    @Test("Failure sets errorMessage and leaves users empty")
    func loadFailure() async throws {
        let useCase = MockFetchUsersUseCase(mode: .failure(TestError.boom))
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        await viewModel.load()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.users.isEmpty)
        #expect(viewModel.errorMessage == TestError.boom.errorDescription)
    }

    @Test("Load using MockUsers.json")
    func loadFromMockJSON() async throws {
        // Try to load from the included MockUsers.json via the Bundle helper.
        let usersFromJSON: [User] = Bundle.main.decode([User].self, from: "MockUsers") ?? []
        let useCase = MockFetchUsersUseCase(mode: .success(usersFromJSON))
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        
        await viewModel.load()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.users.count == usersFromJSON.count)
        if let expectedFirst = usersFromJSON.first {
            #expect(viewModel.users.first == expectedFirst)
        }
        #expect(viewModel.errorMessage == nil)
    }
}

@Suite("UsersViewModel error presentation")
@MainActor
struct UsersViewModelErrorPresentationTests {

    private struct ThrowingUseCase: FetchUsersUseCaseProtocol {
        let error: Error
        func execute() async throws -> [User] { throw error }
    }

    @Test
    func showsUnauthorizedMessage() async {
        let useCase = ThrowingUseCase(error: NetworkError.statusCode(401))
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        await viewModel.load()

        #expect(viewModel.errorMessage == NetworkError.statusCode(401).errorDescription)
    }

    @Test
    func showsOfflineMessage() async {
        let useCase = ThrowingUseCase(error: NetworkError.transport(URLError(.notConnectedToInternet)))
        let viewModel = UsersViewModel(fetchUsersUseCase: useCase)

        await viewModel.load()

        #expect(viewModel.errorMessage == NetworkError.transport(URLError(.notConnectedToInternet)).errorDescription)
    }
}

