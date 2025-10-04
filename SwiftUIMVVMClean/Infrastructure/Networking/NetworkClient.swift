//
//  NetworkClient.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 04.10.25.
//


import Foundation

public protocol NetworkClient {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
