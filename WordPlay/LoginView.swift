//
//  LoginView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/31/24.
//

import SwiftUI
import FirebaseCore

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
