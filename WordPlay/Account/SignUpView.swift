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
    @State private var showAlert = false
    @State private var alertMessage = ""

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
            Button("Sign Up") {
                if email.isEmpty || password.isEmpty {
                    alertMessage = "Please fill in both email and password."
                    showAlert = true
                } else {
                    Task {
                        let success = await authManager.signUp(email: email, password: password)
                        await authManager.signIn(email: email, password: password)
                        
                        if !success {
                            alertMessage = "Unable to create account. Please try again."
                            showAlert = true
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent) // <-- Style button
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Sign Up Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }
}
