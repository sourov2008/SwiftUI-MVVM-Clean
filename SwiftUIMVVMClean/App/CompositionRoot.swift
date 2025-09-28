//
//  CompositionRoot.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 28.09.25.
//

import Foundation
import SwiftUI

struct CompositionRoot {

    func makeUsersView() -> some View {
        let viewModel = makeUsersViewModel()
        return UsersView(viewModel: viewModel)
    }

    func makeUsersViewModel() -> UsersViewModel {
        UsersViewModel(fetchUsersUseCase: makeFetchUsersUseCase())
    }

    func makeFetchUsersUseCase() -> FetchUsersUseCaseProtocol {
        FetchUsersUseCase(repository: makeUserRepository())
    }

    func makeUserRepository() -> UserRepository {
        RemoteUserRepository()
    }
}
