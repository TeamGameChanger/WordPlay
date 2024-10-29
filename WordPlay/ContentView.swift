//
//  ContentView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome to WordPlay!")
        }
        .padding()
    }
}

struct LoginView: View {
    var body: some View {
        Text("Login") // placeholder
    }
}

struct SignUpView: View {
    var body: some View {
        Text("Sign Up") // placeholder
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
    ContentView()
}
