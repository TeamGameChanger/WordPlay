//
//  KeyboardView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/31/24. 🎃
//

import SwiftUI

struct KeyboardView: View {
    @Binding var enteredLetters: String
    @Binding var gameOver: Bool
    let columnskeyboard = [
                GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40))
    ]
    @State var isInRightPositionKeyboard: [Bool] = Array(repeating: false, count: 26)//user selects letter in correct position
    @State var isInWordAndSelectedKeyboard: [Bool] = Array(repeating: false, count: 26)//user selects right letter wrong spot
    @State var isNotInWordAndSelectedKeyboard: [Bool] = Array(repeating: false, count: 26)//user selects wrong letter
    @State var keyboardtiles: [Tile] = [Tile(letter: "Q"), Tile(letter: "W"), Tile(letter: "E"), Tile(letter: "R"), Tile(letter: "T"), Tile(letter: "Y"), Tile(letter: "U"), Tile(letter: "I"), Tile(letter: "O"), Tile(letter: "P"), Tile(letter: "A"), Tile(letter: "S"), Tile(letter: "D"), Tile(letter: "F"), Tile(letter: "G"), Tile(letter: "H"), Tile(letter: "J"), Tile(letter: "K"), Tile(letter: "L"), Tile(letter: "Z"), Tile(letter: "X"), Tile(letter: "C"), Tile(letter: "V"), Tile(letter: "B"), Tile(letter: "N"), Tile(letter: "M")] //the entire keyboard
    let wordtoSolve: String

    var body: some View {
        LazyVGrid(columns: columnskeyboard) {
            ForEach(0..<keyboardtiles.count){ index in
                LetterTileView(tile: keyboardtiles[index], isInRightPosition: $isInRightPositionKeyboard[index], isInWordAndSelected: $isInWordAndSelectedKeyboard[index], isNotInWordAndSelected: $isNotInWordAndSelectedKeyboard[index], onTapOnContent:{
                        print("i was tapped!") //add more brain
                    if !gameOver {
                        if(enteredLetters.count < 5){ //checks that user isnt putting in more than 5 letters
                            enteredLetters = enteredLetters + keyboardtiles[index].letter
                            print("numOfLettersEntered: \(enteredLetters.count), enteredLetters: \(enteredLetters)")
                            if(wordtoSolve.contains(keyboardtiles[index].letter)){
                                if(checkLetterPostion(letter: keyboardtiles[index].letter) == 0){
                                    isInRightPositionKeyboard[index] = true
                                    isInWordAndSelectedKeyboard[index] = false
                                    isNotInWordAndSelectedKeyboard[index] = false
                                }//end of inner if statment to check return value
                                else{
                                    isInRightPositionKeyboard[index] = false
                                    isInWordAndSelectedKeyboard[index] = true
                                    isNotInWordAndSelectedKeyboard[index] = false
                                }//else end of inner if statement to check return value
                            }//end of if statement
                            else{
                                isInRightPositionKeyboard[index] = false
                                isInWordAndSelectedKeyboard[index] = false
                                isNotInWordAndSelectedKeyboard[index] = true
                            }//end of if statement for seeing if the letter was in the word
                        }//end of if statemnt for checking length
                        else{
                            print("Too many letters!")
                        }//other end of if statemnt for checking length
                    } // end of if statement to check if game has ended
                })//end of letterTileView
            }//end of foreach
        }//end of lazyV grid
    }//end of body some view
    
    func checkLetterPostion(letter:String) -> Int{
        if(wordtoSolve[enteredLetters.count-1] == letter){
            return 0; //return 0 which means yes! the letter is there in that position congrats
        }else{
            return 1; //return 1 if it is not in that postiion. too bad
        }//end of if statment
    }//end of checkLetterPostion func
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
