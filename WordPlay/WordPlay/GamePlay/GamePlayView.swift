//
//  GamePlayView.swift
//  WordPlay
//
//  Created by Elysse V on 10/30/24.
//

import SwiftUI

struct GamePlayView: View {
    @Environment(AuthManager.self) var authManager
    @State private var isShowingStatsView = false
    @State var currentInput = ""
    @State var gameOver = false
    @State var currentRow = 0
    @State private var stats: Stats? = nil  // Holds user's stats data
    
    // TODO: Update to handle both 5 letter and 6 letter words (5x6 or 6x6 grid)
    @State var gridTiles: [[GridTileView]] = Array(repeating: Array(repeating: GridTileView(letter: ""), count: 5), count: 6)
    
    let targetWord = "CRATE" //TODO: replace with the actual word needed to solve the wordplay
    
    
    private let firestoreManager = FirestoreManager()  // Firestore manager for CRUD operations
    
    var body: some View {
        GridView(tiles: $gridTiles)
        
        Spacer()
        
        // TODO: Backspace button
        // TODO: Change keyboard colors only when word is submitted
        // TODO: Do not override green or dark gray keyboard tile colors
        KeyboardView(enteredLetters: $currentInput,
                     gameOver: $gameOver,
                     wordtoSolve: targetWord)
        .onChange(of: currentInput) {
            if !gameOver {
                for index in 0..<gridTiles[currentRow].count {
                    if index < currentInput.count {
                        gridTiles[currentRow][index].letter = String(currentInput[index])
                    } else {
                        gridTiles[currentRow][index].letter = ""
                    }
                    
                    gridTiles[currentRow][index].borderColor = Color.black
                }
            }
        }
        
        Button("Submit") {
            if !gameOver && currentInput.count == 5 {
                updateTileColors()
                
                if currentInput == targetWord {
                    print("Game win")
                    gameOver = true
                    // TODO: Trigger game end code
                    updateStats(win: true)
                }
                
                // TODO: Check if input is a valid word
                
                currentRow += 1
                currentInput = ""
                
                if currentRow > 5 {
                    print("Game end")
                    gameOver = true
                    // TODO: Trigger game end code
                    updateStats(win: false)
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .navigationTitle("Game")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Left-aligned button (Statistics)
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Statistics") {
                    // Action for statistics button
                    isShowingStatsView = true
                }
            }
            
            // Right-aligned button (Sign out)
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Sign out") {
                    authManager.signOut()
                }
            }
        }
        .navigationDestination(isPresented: $isShowingStatsView, destination: { StatsView(username: authManager.user?.email ?? "")})
        .onAppear {
            loadOrCreateStats()
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
                let initialStats = Stats(username: username, streak: 0, totalWon: 0, totalGames: 0, lastGameDate: Date(), defaultSize: 15)
                firestoreManager.saveStats(initialStats) { saveResult in
                    if case .success = saveResult {
                        stats = initialStats
                    }
                }
            }
        }
    }
    
    // Update stats after a game
    private func updateStats(win: Bool) {
        guard var updatedStats = stats else { return }
        
        updatedStats.totalGames += 1
        updatedStats.lastGameDate = Date()
        
        if win {
            updatedStats.totalWon += 1
            updatedStats.streak += 1
        } else {
            updatedStats.streak = 0
        }
        
        firestoreManager.updateStats(updatedStats) { result in
            switch result {
            case .success():
                stats = updatedStats
            case .failure(let error):
                print("Error updating stats: \(error.localizedDescription)")
            }
        }
    }
    
    // determines what color the grid tiles should be after submitting a word
    func updateTileColors() {
        let target = Array(targetWord) // makes accessing characters simpler
        var frequencies = target.reduce(into: [:]) { counts, char in
            counts[char, default: 0] += 1
        }
        
        for (index, letter) in currentInput.enumerated() {
            if letter == target[index] {
                gridTiles[currentRow][index].backgroundColor = Color.green
            }
            else if let count = frequencies[letter], count > 0 {
                gridTiles[currentRow][index].backgroundColor = Color.yellow
                frequencies[letter]! -= 1
            }
            else {
                gridTiles[currentRow][index].backgroundColor = Color.gray
            }
            
            gridTiles[currentRow][index].textColor = Color.white
            gridTiles[currentRow][index].borderColor = Color.clear
        }
    }
}

#Preview {
    GamePlayView()
}
