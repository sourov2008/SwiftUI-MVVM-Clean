//
//  NetworkError.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 04.10.25.
//


import Foundation

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
            return "Failed to decode: \(error.localizedDescription)"
        case .transport(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

public struct HTTP {
    public static func decode<T: Decodable>(_ data: Data, as: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }

    public static func validate(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard 200...299 ~= http.statusCode else {
            throw NetworkError.statusCode(http.statusCode)
        }
    }
}
