//
//  AppConfiguration.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//


import Foundation

public struct AppConfiguration {
    public static let shared = AppConfiguration()
    private init() {}

    private let baseURLKey = "BASE_URL"

    public var baseURL: URL {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info.plist not found in main bundle.")
        }
        guard let baseURLString = dict[baseURLKey] as? String, !baseURLString.isEmpty else {
            fatalError("Missing or empty \(baseURLKey) in Info.plist. Ensure it is mapped from your User-Defined build setting.")
        }
        guard let url = URL(string: baseURLString) else {
            fatalError("Invalid BASE_URL string: \(baseURLString)")
        }
        return url
    }
}
