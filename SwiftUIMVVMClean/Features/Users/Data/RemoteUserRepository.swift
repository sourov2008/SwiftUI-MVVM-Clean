//
//  RemoteUserRepository.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//

import Foundation

public struct RemoteUserRepository: UserRepository {
    private let network: NetworkClient
    private let config: AppConfiguration

    public init(network: NetworkClient, config: AppConfiguration) {
        self.network = network
        self.config = config
    }

    public func fetchUsers() async throws -> [User] {
        do {
            let url = config.baseURL.appendingPathComponent("users")
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            let (data, response) = try await network.data(for: request)
            try HTTP.validate(response)
            return try HTTP.decode(data, as: [User].self)
        } catch {
            if let nserror = error as? NetworkError {
                throw nserror
            }
            throw NetworkError.transport(error)
        }
    }
}
