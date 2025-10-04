//
//  File.swift
//  SwiftUIMVVMClean
//
//  Created by Shourob Office  on 23.09.25.
//


import Foundation

extension Bundle {

    func decode<T: Decodable>(_ type: T.Type, from fileName: String) -> T? {
        guard let url = self.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
