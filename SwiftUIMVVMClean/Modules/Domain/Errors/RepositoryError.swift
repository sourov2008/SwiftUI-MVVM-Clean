//
//  RepositoryError.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 28.09.25.
//

import Foundation

public enum RepositoryError: Error, LocalizedError {
    case unauthorized              // 401
    case notFound                  // 404
    case server(status: Int)       // 5xx or other server errors
    case offline                   // no internet / network issues
    case timeout
    case decoding                  // bad/changed JSON
    case badRequest                // 400
    case rateLimited(retryAfter: TimeInterval?)
    case unknown(underlying: Error)

    // TODO: localize the strings
    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "You’re not authorized to perform this action. Please sign in again."
        case .notFound:
            return "We couldn’t find what you’re looking for."
        case .server(let status):
            return "The server encountered a problem (code: \(status)). Please try again later."
        case .offline:
            return "You appear to be offline. Check your internet connection and try again."
        case .timeout:
            return "The request timed out. Please try again."
        case .decoding:
            return "We couldn’t process the server response. Please try again later."
        case .badRequest:
            return "The request was invalid. Please try again."
        case .rateLimited(let retryAfter):
            if let retryAfter, retryAfter > 0 {
                return "You’re doing that too often. Try again in \(Int(retryAfter)) seconds."
            } else {
                return "You’re doing that too often. Please try again shortly."
            }
        case .unknown:
            return "The operation couldn’t be completed due to an unexpected error."
        }
    }
}
