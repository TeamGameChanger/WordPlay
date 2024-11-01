//
//  GamePlayView.swift
//  WordPlay
//
//  Created by Elysse V on 10/30/24.
//

import SwiftUI

struct GamePlayView: View {
    @State var currentInput = ""
    @State var gameOver = false
    @State var currentRow = 0
    
    // TODO: Update to handle both 5 letter and 6 letter words (5x6 or 6x6 grid)
    @State var gridTiles: [[GridTileView]] = Array(repeating: Array(repeating: GridTileView(letter: ""), count: 5), count: 6)

    let targetWord = "CRATE" //TODO: replace with the actual word needed to solve the wordplay
    
    var body: some View {
        GridView(tiles: $gridTiles)
        
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
                    }
                }
            }
        
        Button("Submit") {
            if !gameOver && currentInput.count == 5 {
                if currentInput == targetWord {
                    print("Game win")
                    gameOver = true
                    // TODO: Trigger game end code
                }
                
                // TODO: Check if input is a valid word
                // TODO: Update colors of tiles based on correctness (matching keyboard colors)
                
                currentRow += 1
                currentInput = ""
                
                if currentRow > 5 {
                    print("Game end")
                    gameOver = true
                    // TODO: Trigger game end code
                }
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    GamePlayView()
}
