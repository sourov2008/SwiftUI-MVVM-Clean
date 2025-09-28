//
//  SwiftUIMVVMCleanApp.swift
//  SwiftUIMVVMClean
//
//  Created by Guest Datta on 22.09.25.
//

import SwiftUI

@main
struct SwiftUIMVVMCleanApp: App {
    var body: some Scene {
        WindowGroup {
            let root = CompositionRoot()
            root.makeUsersView()
        }
    }
}
