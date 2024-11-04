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
    
    // remove later
    @State var wordLength = 5
    
    var body: some View {
        NavigationView {
            VStack {
                LoginView()
                
                NavigationLink(destination: GamePlayView(wordLength: wordLength)) {
                    Text("test: go to game") //remove element afterwards, this is just to skip signing up
                        .padding()
                }//end of test navigation
                
                // remove later, used to test grid for 5 and 6 letter word
                HStack {
                    Text("Word Length:")
                    Picker("", selection: $wordLength) {
                        Text("5").tag(5)
                        Text("6").tag(6)
                    }
                    .pickerStyle(.palette)
                    .frame(width: 100)
                }
            }
        }
    }
}

struct GameStartView: View {
    var body: some View {
        Text("Game Start") // placeholder
    }
}

#Preview {
    ContentView().environment(AuthManager()) 
}
