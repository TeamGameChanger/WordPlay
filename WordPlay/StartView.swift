//
//  StartView.swift
//  WordPlay
//
//  Created by Camila Gloria on 11/16/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var stats: Stats? = nil  // Holds user's stats data
    @State private var fiveLetterWord = "CRATE"
    @State private var sixLetterWord = "CRATER"
    @State var wordLength = 5
    private let options = ["5 letter word", "6 letter word"]

    private let firestoreManager = FirestoreManager()

    var body: some View {
        NavigationView {
            if stats == nil {
                ProgressView("Loading...")
            } else {
                VStack {
                    Spacer()
                        .frame(height: 10)
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack {
                        Text("Select Gameplay Mode")
                            .bold()
                    
                        ForEach(options, id: \.self) { option in
                            HStack {
                                Image(systemName: wordLength == getTag(for: option) ? "circle.fill" : "circle")
                                
                                Text(option)
                            }
                            .padding(5)
                            .foregroundColor(wordLength == getTag(for: option) ? .blue : .black)
                            .onTapGesture {
                                wordLength = getTag(for: option)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                        .frame(height: 30)
                    
                    NavigationLink(destination: GamePlayView(stats: stats, wordLength: wordLength, targetWord: wordLength == 5 ? fiveLetterWord : sixLetterWord)) {
                        Text("Play")
                            .padding()
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 80, height: 40)
                            .background(.blue)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            loadOrCreateStats()
            
            // initializes 5 and 6 letter word lists if not already initialized
            WordList.shared.initialize()
            
            fiveLetterWord = WordList.shared.fiveLetterWords.randomElement()?.uppercased() ?? fiveLetterWord
            sixLetterWord = WordList.shared.sixLetterWords.randomElement()?.uppercased() ?? sixLetterWord
            
            print("5 letter word: \(fiveLetterWord)")
            print("6 letter word: \(sixLetterWord)")
        }
        .navigationTitle("WordPlay")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: StatsView(username: authManager.user?.email ?? "")) {
                    Text("Statistics")
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Sign Out") {
                    authManager.signOut()
                }
            }
        }
    }
    
    private func getTag(for option: String) -> Int {
        switch option {
        case "5 letter word":
            return 5
        case "6 letter word":
            return 6
        default:
            return 5
        }
    }

    // Load or create initial stats for the user
    private func loadOrCreateStats() {
        guard let username = authManager.user?.email else { return }

        firestoreManager.fetchStats(forUsername: username) { result in
            switch result {
            case .success(let fetchedStats):
                stats = fetchedStats  // Existing record loaded
            case .failure:
                // No record found, create initial stats
                let initialStats = Stats(username: username, streak: 0, totalWon: 0, totalGames: 0, lastGameDate: Date(), defaultSize: wordLength)
                firestoreManager.saveStats(initialStats) { saveResult in
                    if case .success = saveResult {
                        stats = initialStats
                    }
                }
            }
        }
    }
}
