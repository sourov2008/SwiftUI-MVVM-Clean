//
//  RemoteUserRepository.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//


import Foundation

public struct RemoteUserRepository: UserRepository {
    private let client: HTTPClient
    private let config: AppConfiguration

    public init(client: HTTPClient = .shared, config: AppConfiguration = .shared) {
        self.client = client
        self.config = config
    }

    public func fetchUsers() async throws -> [User] {
        let url = config.baseURL.appendingPathComponent("users")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return try await client.request(request, as: [User].self)
    }
}
