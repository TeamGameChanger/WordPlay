//
//  SignUpView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/31/24.
//

import SwiftUI
import FirebaseCore

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
                    Task {
                        await authManager.signIn(email: email, password: password)
                    }
                }
                .buttonStyle(.borderedProminent) // <-- Style button
            }
        }
    }
}
