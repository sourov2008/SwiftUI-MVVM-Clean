//
//  SwiftUIMVVMCleanApp.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//

import SwiftUI

@main
struct SwiftUIMVVMCleanApp: App {
    var body: some Scene {
        WindowGroup {
            let userRepository = RemoteUserRepository()
            let fetchUsersUseCase = FetchUsersUseCase(repository: userRepository)
            let viewModel = UsersViewModel(fetchUsersUseCase: fetchUsersUseCase)
            UsersView(viewModel: viewModel)
        }
    }
}
