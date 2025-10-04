//
//  FetchUsersUseCase.swift
//  SwiftUIMVVMClean
//
//  Created by Shourob Office  on 23.09.25.
//

import Foundation

public protocol FetchUsersUseCaseProtocol {
    func execute() async throws -> [User]
}

public struct FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let repository: UserRepository

    public init(repository: UserRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [User] {
        return try await repository.fetchUsers()
    }
}

