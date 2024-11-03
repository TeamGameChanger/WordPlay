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
    ContentView().environment(AuthManager()) 
}
