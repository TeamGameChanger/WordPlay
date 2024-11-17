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
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .padding(40)
            
            Button("Login") {
                if email.isEmpty || password.isEmpty {
                    alertMessage = "Please fill in both email and password."
                    showAlert = true
                } else {
                    print("Login user: \(email), \(password)")
                    Task {
                        let success = await authManager.signIn(email: email, password: password)
                        
                        if !success {
                            alertMessage = "Unable to login. Please try again."
                            showAlert = true
                        }
                    }
                }
            }
            .bold()
            .foregroundColor(.white)
            .frame(width: 80, height: 40)
            .background(.blue)
            .cornerRadius(20)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Text("Don't have an account yet?")
                .padding(.top, 40)
            
            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
                    .padding(.top, 5)
                    .bold()
            }
        }
        .padding()
    }
}
