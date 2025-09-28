//
//  MockUsersRepository.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 28.09.25.
//

import Testing
@testable import SwiftUIMVVMClean
import Foundation

private struct MockUsersRepository: UserRepository {
    var toReturn: [User] = []
    func fetchUsers() async throws -> [User] { toReturn }
}

@Suite("FetchUsersUseCase unit tests")
struct FetchUsersUseCaseTests {
    @Test
    func returnsUsersFromRepository() async throws {
        let usersFromJSON: [User] = Bundle.main.decode([User].self, from: "MockUsers") ?? []
        let repo = MockUsersRepository(toReturn: usersFromJSON)
        let sut = await FetchUsersUseCase(repository: repo)

        let users = try await sut.execute()

        #expect(users.count == usersFromJSON.count)
        if let expectedFirst = usersFromJSON.first {
            #expect(users.first == expectedFirst)
        }
    }
}

