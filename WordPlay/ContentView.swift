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

struct LoginView: View {
    @Environment(AuthManager.self) var authManager
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showEmptyFieldsAlert = false

    var body: some View {
        Text("WordPlay")
            .font(.largeTitle)

        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
        }
        .textFieldStyle(.roundedBorder)
        .textInputAutocapitalization(.never)
        .padding(40)

        Button("Login") {
            if email.isEmpty || password.isEmpty {
                showEmptyFieldsAlert = true
            }
    
            print("Login user: \(email), \(password)")
            authManager.signIn(email: email, password: password)
        }
        .buttonStyle(.borderedProminent)
        .alert(isPresented: $showEmptyFieldsAlert) {
            Alert(
                title: Text("Missing Fields"),
                message: Text("Please enter your username and password."),
                dismissButton: .default(Text("OK"))
            )
        }
    
        Text("Don't have an account yet?")
            .padding(.top, 40)

        NavigationLink(destination: SignUpView()) {
            Text("Sign Up")
                .padding(.top, 5)
        }
    }
}

struct SignUpView: View {
    @Environment(AuthManager.self) var authManager
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Sign Up for WordPlay!")
                .font(.largeTitle)

            // Email + password fields
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder) // <-- Style text fields (applies to both text fields within the VStack)
            .textInputAutocapitalization(.never) // <-- No auto capitalization (can be annoying for emails and passwords)
            .padding(40)

            // Sign up button
            HStack {
                Button("Sign Up") {
                    print("Sign up user: \(email), \(password)")
                    authManager.signUp(email: email, password: password)
                    authManager.signIn(email: email, password: password)
                }
                .buttonStyle(.borderedProminent) // <-- Style button
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
