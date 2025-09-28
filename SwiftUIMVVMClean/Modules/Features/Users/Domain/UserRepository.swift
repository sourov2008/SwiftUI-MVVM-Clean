//
//  UserRepository.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//

import Foundation

public protocol UserRepository {
    func fetchUsers() async throws -> [User]
}
