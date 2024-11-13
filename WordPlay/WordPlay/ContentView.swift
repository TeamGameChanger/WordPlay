//
//  ContentView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/29/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @Environment(AuthManager.self) var authManager
    var body: some View {
        NavigationView {
            LoginView()
//            VStack {
//                
//            }
        }
    }
}

struct GameStartView: View {
    var body: some View {
        Text("Game Start") // placeholder
    }
}

#Preview {
    ContentView().environment(AuthManager()) 
}
