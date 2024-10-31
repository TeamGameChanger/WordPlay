//
//  ContentView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/29/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
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
                
                NavigationLink(destination: GamePlayView()) {
                    Text("test: go to game") //remove element afterwards, this is just to skip signing up
                        .padding()
                }//end of test navigation
            }
            .padding()
        }
    }
}

struct LoginView: View {
    var body: some View {
        Text("Login") // placeholder
    }
}

struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("WordPlay")
                .bold()
                .font(.largeTitle)
                .padding()
                .foregroundColor(Color.blue)
            
            Spacer()
                .frame(height: 75)
            
            Text("Sign Up")
                .bold()
                .font(.title)
                .padding()
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
                .padding(.top)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
                .padding(.bottom)
            
            Button("Register") {
                // Register user
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .padding()
            
            Spacer()
        }
    }
}

struct GameStartView: View {
    var body: some View {
        Text("Game Start") // placeholder
    }
}

//im not actually sure if this does anything
struct GameplayView: View { //ely work here
    var body: some View{
        GameplayView()
    }//end of body some view
}//end of gameplayview struct

#Preview {
    ContentView()
}
