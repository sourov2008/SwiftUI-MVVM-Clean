//
//  URLSessionNetworkClient.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 04.10.25.
//


import Foundation

public final class URLSessionNetworkClient: NetworkClient {
    private let session: URLSession

    public init(session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()) {
        self.session = session
    }

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
