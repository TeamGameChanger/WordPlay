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
    @Binding var submitPressed: Bool
    let columnskeyboard = [
                GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40))
    ]
    @State var isInRightPositionKeyboard: [Bool] = Array(repeating: false, count: 26)//user selects letter in correct position
    @State var isInWordAndSelectedKeyboard: [Bool] = Array(repeating: false, count: 26)//user selects right letter wrong spot
    @State var isNotInWordAndSelectedKeyboard: [Bool] = Array(repeating: false, count: 26)//user selects wrong letter
    @State var keyboardtiles: [Tile] = [Tile(letter: "Q"), Tile(letter: "W"), Tile(letter: "E"), Tile(letter: "R"), Tile(letter: "T"), Tile(letter: "Y"), Tile(letter: "U"), Tile(letter: "I"), Tile(letter: "O"), Tile(letter: "P"), Tile(letter: "A"), Tile(letter: "S"), Tile(letter: "D"), Tile(letter: "F"), Tile(letter: "G"), Tile(letter: "H"), Tile(letter: "J"), Tile(letter: "K"), Tile(letter: "L"), Tile(letter: "Z"), Tile(letter: "X"), Tile(letter: "C"), Tile(letter: "V"), Tile(letter: "B"), Tile(letter: "N"), Tile(letter: "M")] //the entire keyboard
    @State var enteredLettersMorePermananet = ""
    let wordtoSolve: String

    var body: some View {
        LazyVGrid(columns: columnskeyboard) {
            ForEach(0..<keyboardtiles.count){ index in
                LetterTileView(tile: keyboardtiles[index], isInRightPosition: $isInRightPositionKeyboard[index], isInWordAndSelected: $isInWordAndSelectedKeyboard[index], isNotInWordAndSelected: $isNotInWordAndSelectedKeyboard[index], onTapOnContent:{
                        print("i was tapped!") //add more brain
                    if !gameOver {
                        if(enteredLetters.count < 5){ //checks that user isnt putting in more than 5 letters
                            enteredLetters = enteredLetters + keyboardtiles[index].letter
                            enteredLettersMorePermananet = enteredLetters
                            print("numOfLettersEntered: \(enteredLetters.count), enteredLetters: \(enteredLetters), enteredLettersMorePermananet: \(enteredLettersMorePermananet)")
                        }//end of if statemnt for checking length
                        else{
                            print("Too many letters!")
                        }//other end of if statemnt for checking length
                    } // end of if statement to check if game has ended
                })//end of letterTileView
                .onChange(of: submitPressed){
                    if (submitPressed == true){
                        submitPressedCheck(enteredletters2: enteredLettersMorePermananet)
                    }
                }//end of onChange
            }//end of foreach
        }//end of lazyV grid
    }//end of body some view
    
    func checkLetterPostion(letter:String) -> Int{
        var distance = -1
        var distance2 = -1
        
        
        var inputString = wordtoSolve
        var target: Character = Character(letter)
        if var index = inputString.firstIndex(of: target) {
            distance = inputString.distance(from: inputString.startIndex, to: index)
           print("Input string: \(inputString)")
           print("Index of '\(target)' is: \(distance)")
        } else {
           print("Character not found")
        }
        
        var enteredString = enteredLettersMorePermananet
        var target2: Character = Character(letter)
        if var index2 = enteredString.firstIndex(of: target2) {
            distance2 = enteredString.distance(from: enteredString.startIndex, to: index2)
           print("Entered string: \(enteredString)")
           print("Index of '\(target2)' is: \(distance2)")
        } else {
           print("Character not found (should not happen)")
        }
        
        if(distance == distance2){
            print("found \(letter) in \(wordtoSolve)! at index \(distance2)")
            return 0; //return 0 which means yes! the letter is there in that position congrats
        }else{
            print("did NOT find \(letter) in \(wordtoSolve).... at index \(distance2)")
            return 1; //return 1 if it is not in that postiion. too bad
        }//end of if statment
    }//end of checkLetterPostion func
    
    func submitPressedCheck(enteredletters2: String){
        var numOfLettersChecked = 0
        print("Entered the check change keyboard thing. Word to solve for is \(wordtoSolve)")
        for i in 0 ..< keyboardtiles.count {
            print("Checking keyboard tile #\(i). \(numOfLettersChecked) letters out of 5 found.")
            if(numOfLettersChecked == wordtoSolve.count){
                print("All letters found. Ending Loop")
                break
            }
            if(enteredletters2.contains(keyboardtiles[i].letter)){
                print("\(keyboardtiles[i].letter) is in our entered letters, \(enteredletters2). checking if \(keyboardtiles[i].letter) is in the word \(wordtoSolve)")
                numOfLettersChecked += 1 //letter has been found, shorten the loop
                if(wordtoSolve.contains(keyboardtiles[i].letter)){
                    if(checkLetterPostion(letter: keyboardtiles[i].letter) == 0){
                        isInRightPositionKeyboard[i] = true
                        isInWordAndSelectedKeyboard[i] = false
                        isNotInWordAndSelectedKeyboard[i] = false
                        print("\(keyboardtiles[i].letter) was set to GREEN")
                    }//end of inner if statment to check return value
                    else{
                        isInRightPositionKeyboard[i] = false
                        isInWordAndSelectedKeyboard[i] = true
                        isNotInWordAndSelectedKeyboard[i] = false
                        print("\(keyboardtiles[i].letter) was set to YELLOW")
                    }//else end of inner if statement to check return value
                }//end of if statement
                else{
                    isInRightPositionKeyboard[i] = false
                    isInWordAndSelectedKeyboard[i] = false
                    isNotInWordAndSelectedKeyboard[i] = true
                    print("\(keyboardtiles[i].letter) not found. setting to GREY")
                }//end of if statement for seeing if the letter was in the word
            }//end of if checking if the keyboard index was used
            else{
                print("not found..  \(keyboardtiles[i].letter) is NOT in \(enteredletters2)")
            }
            
        }//end of for loop
        enteredLettersMorePermananet = ""
        submitPressed.toggle()
        print("set submit pressed to: \(submitPressed); it should be false. enteredLettersMorePermananet is: \(enteredLettersMorePermananet); should be empty. ")
                            
    }//end of submitpressedcheck func
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
