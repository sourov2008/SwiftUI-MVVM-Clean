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

    private let fetchUsersUseCase: FetchUsersUseCaseProtocol

    public init(fetchUsersUseCase: FetchUsersUseCaseProtocol) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    public func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetched = try await fetchUsersUseCase.execute()
            self.users = fetched
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
