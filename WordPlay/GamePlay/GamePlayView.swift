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
    @State var gridTiles: [[GridTileView]] = []

    let wordLength: Int
    // TODO: Replace with the actual word needed to solve the wordplay
    let targetWord = "CRATER"
    
    var body: some View {
        VStack {
            Spacer()
            
            GridView(tiles: $gridTiles)
            
            Spacer()
            
            KeyboardView(enteredLetters: $currentInput,
                         gameOver: $gameOver, submitPressed: $submitPressed,
                         wordtoSolve: targetWord,
                         wordLength: wordLength)
            .onChange(of: currentInput) {
                if !gameOver {
                    for index in 0..<gridTiles[currentRow].count {
                        gridTiles[currentRow][index].letter = index < currentInput.count ? String(currentInput[index]) : ""
                        gridTiles[currentRow][index].borderColor = Color.black
                    }//end of for loop
                }//end of if not gameover
            }//end of on change
            
            Spacer()
        
            HStack{
                Spacer()
                
                Button("Submit") {
                    if !gameOver && currentInput.count == wordLength {
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
                    print("delete pressed. current input is: \(currentInput)")
                    if !gameOver && currentInput.count > 0 {
                        //debugging info
                        let i = currentInput.index(currentInput.startIndex, offsetBy: currentInput.count-1)
                        let charRemoved = currentInput.remove(at: i)
                        print("\(charRemoved) was removed. String is now \(currentInput)")
                        
                    }else{
                        print("Nuh uh. Either no letters left to delete or game is already done. ")
                    }
                } label: {Image(systemName: "delete.backward")}
                    .buttonStyle(.bordered)
                
                Spacer()
            }//end of Hstack
            
            Spacer()
        }
        .onAppear() {
            gridTiles = Array(repeating: Array(repeating: GridTileView(letter: ""), count: wordLength), count: 6)
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
