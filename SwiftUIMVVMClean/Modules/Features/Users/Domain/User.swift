//
//  User.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//


import Foundation

public struct User: Identifiable, Codable, Sendable, Hashable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
    public let phone: String?
    public let website: String?
    public let address: Address?
    public let company: Company?

    public struct Address: Codable, Sendable, Hashable {
        public let street: String?
        public let suite: String?
        public let city: String?
        public let zipcode: String?
    }

    public struct Company: Codable, Sendable, Hashable {
        public let name: String?
        public let catchPhrase: String?
        public let bs: String?
    }
}
