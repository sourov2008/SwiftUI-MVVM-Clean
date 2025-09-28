//
//  HTTPCLient.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//

import Foundation

public final class HTTPClient {
    public static let shared = HTTPClient()
    private init() {}

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()

    public func request<T: Decodable>(_ request: URLRequest, as type: T.Type = T.self) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
            guard 200...299 ~= http.statusCode else { throw NetworkError.statusCode(http.statusCode) }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }
        } catch {
            if let nserror = error as? NetworkError { throw nserror }
            throw NetworkError.transport(error)
        }
    }
}

public enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
    case transport(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server."
        case .statusCode(let code):
            return "Server returned status code \(code)."
        case .decoding(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .transport(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

