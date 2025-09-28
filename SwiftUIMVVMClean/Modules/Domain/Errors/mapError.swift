//
//  mapError.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 28.09.25.
//

import Foundation

func mapError(_ error: Error) -> RepositoryError {
    // Example mappings — adapt to your HTTPClient’s error surface
    if let http = error as? NetworkError {
        switch http {
        case .statusCode(let code):
            switch code {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 404: return .notFound
            case 429:
                return .rateLimited(retryAfter: nil)
            case 500...599: return .server(status: code)
            default: return .server(status: code)
            }
        case .decoding(_):
            return .decoding
        case .invalidResponse:
            return .server(status: -1)
        case .transport(let underlying):
            if let url = underlying as? URLError {
                switch url.code {
                case .notConnectedToInternet, .networkConnectionLost, .cannotFindHost:
                    return .offline
                case .timedOut:
                    return .timeout
                default:
                    return .unknown(underlying: underlying)
                }
            } else {
                return .unknown(underlying: http)
            }
        }
    }

    if let url = error as? URLError {
        switch url.code {
        case .notConnectedToInternet, .networkConnectionLost, .cannotFindHost:
            return .offline
        case .timedOut:
            return .timeout
        default:
            return .unknown(underlying: url)
        }
    }

    return .unknown(underlying: error)
}
