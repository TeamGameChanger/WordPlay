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
    @State var submitPressed = false
    
    // TODO: Update to handle both 5 letter and 6 letter words (5x6 or 6x6 grid)
    @State var gridTiles: [[GridTileView]] = Array(repeating: Array(repeating: GridTileView(letter: ""), count: 5), count: 6)

    let targetWord = "CRATE" //TODO: replace with the actual word needed to solve the wordplay
    
    var body: some View {
        Spacer()
        
        GridView(tiles: $gridTiles)
        
        Spacer()
        
        // TODO: Do not override green or dark gray keyboard tile colors
        KeyboardView(enteredLetters: $currentInput,
                     gameOver: $gameOver, submitPressed: $submitPressed,
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
                    }//end of for loop
                }//end of if not gameover
            }//end of on change
        Spacer()
        HStack{
            Spacer()
            
            Button("Submit") {
                if !gameOver && currentInput.count == 5 {
                    submitPressed.toggle()//needed for keyboard to update
                    updateTileColors()
                    
                    if currentInput == targetWord {
                        print("Game win")
                        gameOver = true
                        // TODO: Trigger game end code
                    }
                    
                    // TODO: Check if input is a valid word
                    
                    currentRow += 1
                    currentInput = ""
                    
                    if currentRow > 5 {
                        print("Game end")
                        gameOver = true
                        // TODO: Trigger game end code
                        //😦
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            // TODO: Backspace button
            Button{
                print("delete pressed")
                if !gameOver && currentInput.count > 0 {
                    
                }
            } label: {Image(systemName: "delete.backward")}
            .buttonStyle(.bordered)
            
            Spacer()
        }//end of Hstack
        Spacer()
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
