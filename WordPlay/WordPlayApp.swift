//
//  WordPlayApp.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/29/24.
//

import SwiftUI
import FirebaseCore // <-- Import Firebase

@main
struct WordPlayApp: App {
    @StateObject private var authManager = AuthManager()

    init() {
        FirebaseApp.configure() // <-- Configure Firebase app
    }

    var body: some Scene {
        WindowGroup {
            if authManager.user != nil { // <-- Check if user is logged in
                NavigationView {
                    StartView()
                        .environmentObject(authManager)
                }
            } else {
                ContentView()
                    .environmentObject(authManager)
            }
        }
    }
}
