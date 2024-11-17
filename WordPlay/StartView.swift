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
    @State var wordLength = 5

    private let firestoreManager = FirestoreManager()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Word Length:")
                    Picker("", selection: $wordLength) {
                        Text("5").tag(5)
                        Text("6").tag(6)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 100)
                }

                NavigationLink(destination: GamePlayView(stats: stats, wordLength: wordLength, targetWord: wordLength == 5 ? "CRATE" : "CRATER")) {
                    Text("Play")
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 40)
                        .background(.blue)
                        .cornerRadius(20)
                }
            }
        }
        .onAppear {
            loadOrCreateStats()
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
