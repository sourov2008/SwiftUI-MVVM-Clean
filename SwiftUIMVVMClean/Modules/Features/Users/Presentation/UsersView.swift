//
//  UsersView.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 23.09.25.
//


import SwiftUI

public struct UsersView: View {
    
    @StateObject var viewModel: UsersViewModel
    
    public var body: some View {
        Group {
            if viewModel.isLoading && viewModel.users.isEmpty {
                ProgressView("Loading Users…")
            } else if let error = viewModel.errorMessage, viewModel.users.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(error)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        Task { await viewModel.load() }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            } else {
                List(viewModel.users) { user in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name)
                            .font(.headline)
                        
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(user.username)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.insetGrouped)
                .refreshable {
                    await viewModel.load()
                }
            }
        }
        .task {
            await viewModel.load()
        }
        .navigationTitle("Users")
    }
}

#Preview {
    struct MockFetchUsersUseCase: FetchUsersUseCaseProtocol {
        func execute() async throws -> [User] {
            return Bundle.main.decode([User].self, from: "MockUsers") ?? []
        }
    }
    let mockUseCase = MockFetchUsersUseCase()
    let viewModel = UsersViewModel(fetchUsersUseCase: mockUseCase)
    return NavigationStack { UsersView(viewModel: viewModel) }
}

