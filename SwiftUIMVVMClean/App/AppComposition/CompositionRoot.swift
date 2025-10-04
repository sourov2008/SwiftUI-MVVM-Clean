//
//  CompositionRoot.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 28.09.25.
//

import Foundation
import SwiftUI

struct CompositionRoot {
    private let config = AppConfiguration.shared
    private let network: NetworkClient = URLSessionNetworkClient()

    func makeUserRepository() -> UserRepository {
        RemoteUserRepository(network: network, config: config)
    }

    func makeFetchUsersUseCase() -> FetchUsersUseCaseProtocol {
        FetchUsersUseCase(repository: makeUserRepository())
    }

    func makeUsersViewModel() -> UsersViewModel {
        UsersViewModel(fetchUsersUseCase: makeFetchUsersUseCase())
    }

    func makeUsersView() -> some View {
        UsersView(viewModel: makeUsersViewModel())
    }
}
