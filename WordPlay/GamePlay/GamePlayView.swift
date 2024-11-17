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
    @State var shouldShake = false

    let wordLength: Int
    let targetWord: String
    
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
                        }//end of for loop
                    }//end of if not gameover
                }//end of on change
            
            Spacer()
        
            HStack{
                Spacer()
                
                Button("Submit") {
                    // initializes 5 and 6 letter word lists if not already initialized
                    WordList.shared.initialize()
                    
                    let wordList = wordLength == 5 ? WordList.shared.fiveLetterWords : WordList.shared.sixLetterWords
                
                    if !gameOver && currentInput.count == wordLength && wordList.contains(currentInput.lowercased()) {
                        submitPressed.toggle()//needed for keyboard to update
                        updateTileColors()
                        
                        if currentInput == targetWord {
                            print("Game win")
                            gameOver = true
                            // TODO: Trigger game end code
                        }
                        
                        currentRow += 1
                        currentInput = ""
                        
                        if currentRow > 5 {
                            print("Game end")
                            gameOver = true
                            // TODO: Trigger game end code
                            //😦
                        }
                    } else if !gameOver {
                        // shake the row tiles if input is not long enough or word is not valid
                        shouldShake = true
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()

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
}
