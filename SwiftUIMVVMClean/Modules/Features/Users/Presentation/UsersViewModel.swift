//
//  UsersViewModel.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//


import Foundation
import SwiftUI
import Combine

@MainActor
public final class UsersViewModel: ObservableObject {
    @Published public private(set) var users: [User] = []
    @Published public private(set) var isLoading: Bool = false
    @Published public var errorMessage: String? = nil

    private let repository: UserRepository

    public init(repository: UserRepository) {
        self.repository = repository
    }

    public convenience init() {
        self.init(repository: RemoteUserRepository())
    }

    public func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetched = try await repository.fetchUsers()
            self.users = fetched
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

