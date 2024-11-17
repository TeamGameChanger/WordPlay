//
//  GamePlayView.swift
//  WordPlay
//
//  Created by Elysse V on 10/30/24.
//

import SwiftUI

struct GamePlayView: View {
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.dismiss) var dismiss
    @State var stats: Stats?  // Holds user's stats data
    @State var currentInput = ""
    @State var gameOver = false
    @State var currentRow = 0
    @State var submitPressed = false
    @State var gridTiles: [[GridTileView]] = []
    @State var shouldShake = false
    @State var foundWord = false

    let wordLength: Int
    let targetWord: String
    
    private let firestoreManager = FirestoreManager()
    
    var body: some View {
        VStack {
            Spacer()
            
            GridView(tiles: $gridTiles,
                     shouldShake: $shouldShake,
                     currentRow: $currentRow)
            
            Spacer()
            
            KeyboardView(enteredLetters: $currentInput,
                         gameOver: $gameOver, submitPressed: $submitPressed,
                         wordtoSolve: targetWord,
                         wordLength: wordLength)
                .onAppear() {
                    for index in 0..<gridTiles[currentRow].count {
                        gridTiles[currentRow][index].borderColor = Color(UIColor.darkGray)
                    }
                }
                .onChange(of: currentInput) {
                    if !gameOver {
                        for index in 0..<gridTiles[currentRow].count {
                            gridTiles[currentRow][index].letter = index < currentInput.count ? String(currentInput[index]) : ""
                            gridTiles[currentRow][index].borderColor = Color(UIColor.darkGray)
                        }
                    }
                }
            
            Spacer()
        
            HStack {
                Spacer()
                
                Button("Submit") {
                    let wordList = wordLength == 5 ? WordList.shared.fiveLetterWords : WordList.shared.sixLetterWords
                
                    if !gameOver && currentInput.count == wordLength && wordList.contains(currentInput.lowercased()) {
                        submitPressed.toggle() // needed for keyboard to update
                        updateTileColors()
                        
                        if currentInput == targetWord {
                            print("Game win")
                            foundWord = true
                            gameOver = true
                            updateStats(win: true)
                        }
                        
                        currentRow += 1
                        currentInput = ""
                        
                        if currentRow > 5 {
                            print("Game end")
                            gameOver = true
                            updateStats(win: false)
                        }
                    } else if !gameOver {
                        // shake the row tiles if input is not long enough or word is not valid
                        shouldShake = true
                    }
                }
                .alert(isPresented: $gameOver) {
                    Alert(
                        title: Text(foundWord == true ? "You won!" : "You lost!!" ),
                        message: Text(foundWord == true ? "Fantastic job!!" : "Better luck next time."),
                           dismissButton: .default(Text("Got it!") , action: {
                               dismiss() // go back to start screen
                           })
                        )
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()

                Button {
                    print("delete pressed. current input is: \(currentInput)")
                    if !gameOver && currentInput.count > 0 {
                        //debugging info
                        let i = currentInput.index(currentInput.startIndex, offsetBy: currentInput.count-1)
                        let charRemoved = currentInput.remove(at: i)
                        print("\(charRemoved) was removed. String is now \(currentInput)")
                    } else {
                        print("Nuh uh. Either no letters left to delete or game is already done.")
                    }
                } label: {
                    Image(systemName: "delete.backward")
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            
            Spacer()
        }
        .onAppear {
            gridTiles = Array(repeating: Array(repeating: GridTileView(letter: ""), count: wordLength), count: 6)
        }
    }
    
    // determines what color the grid tiles should be after submitting a word
    func updateTileColors() {
        let target = Array(targetWord) // makes accessing characters simpler
        let current = Array(currentInput)
        var frequencies = target.reduce(into: [:]) { counts, char in
            counts[char, default: 0] += 1
        }
        
        // assign green tiles
        for (index, letter) in target.enumerated() {
            if letter == current[index] {
                gridTiles[currentRow][index].backgroundColor = Color.green
                gridTiles[currentRow][index].textColor = Color.white
                gridTiles[currentRow][index].borderColor = Color.clear
                frequencies[letter]! -= 1
            }
        }
        
        // assign yellow and gray tiles
        for (index, letter) in current.enumerated() {
            if letter != target[index] {
                if let count = frequencies[letter], count > 0 {
                    gridTiles[currentRow][index].backgroundColor = Color.yellow
                    frequencies[letter]! -= 1
                }
                else {
                    gridTiles[currentRow][index].backgroundColor = Color.gray
                }
            }

            gridTiles[currentRow][index].textColor = Color.white
            gridTiles[currentRow][index].borderColor = Color.clear
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
}
