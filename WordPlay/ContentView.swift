//
//  ContentView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/29/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) var authManager
    var body: some View {
        NavigationView {
            VStack {
                LoginView()
            }
            .padding()
        }
    }
}

struct GameStartView: View {
    var body: some View {
        Text("Game Start") // placeholder
    }
}

struct GameplayView: View {
    var body: some View {
        Text("Gameplay") // placeholder
    }
}

#Preview {
    ContentView().environment(AuthManager()) 
}
