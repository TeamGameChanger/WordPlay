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
    @State private var authManager: AuthManager
    
    init() { // <-- Add an init
        FirebaseApp.configure() // <-- Configure Firebase app
        authManager = AuthManager()
    }
    
    var body: some Scene {
        WindowGroup {
            if authManager.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)
                
                // We have a logged in user, go to ChatView
                NavigationStack {
                    GamePlayView().environment(authManager)
                }
            } else {
                ContentView().environment(authManager)
            }
        }
    }
}



