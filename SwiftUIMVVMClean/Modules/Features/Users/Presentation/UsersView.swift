//
//  UsersView.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 23.09.25.
//


import SwiftUI

public struct UsersView: View {
    @StateObject var viewModel = UsersViewModel()

    public init() {}

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
                        if !user.email.isEmpty {
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        } else if !user.username.isEmpty {
                            Text(user.username)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
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
    NavigationStack { UsersView() }
}
