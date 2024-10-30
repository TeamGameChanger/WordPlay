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
                Image(systemName: "gamecontroller")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome to WordPlay!")
        
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .padding()
                }
            }
            .padding()
        }
    }
}

struct LoginView: View {
    @Environment(AuthManager.self) var authManager
    var body: some View {
        Text("Login") // placeholder
    }
}

struct SignUpView: View {
    
    @Environment(AuthManager.self) var authManager
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Sign Up for Wordplay!")
                .font(.largeTitle)

            // Email + password fields
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder) // <-- Style text fields (applies to both text fields within the VStack)
            .textInputAutocapitalization(.never) // <-- No auto capitalization (can be annoying for emails and passwords)
            .padding(40)

            // Sign up + Login buttons
            HStack {
                Button("Sign Up") {
                    print("Sign up user: \(email), \(password)")
                    authManager.signUp(email: email, password: password)

                }
                .buttonStyle(.borderedProminent) // <-- Style button

                Button("Login") {
                    print("Login user: \(email), \(password)")
                    authManager.signIn(email: email, password: password)

                }
                .buttonStyle(.bordered) // <-- Style button
            }
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
