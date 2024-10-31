//
//  LetterTileView.swift
//  WordPlay
//
//  Created by Elysse V on 10/30/24.
//

import SwiftUI

struct LetterTileView: View {
    let tile: Tile
    @Binding var isInRightPosition: Bool //user selects letter in correct position
    @Binding var isInWordAndSelected: Bool //user selects right letter wrong spot
    @Binding var isNotInWordAndSelected: Bool //user selects wrong letter
    var onTapOnContent: (() -> Void)? // <-- Add closures to be called when user swipes left or right
    var body: some View {
        ZStack{
            if(isInRightPosition == false && isInWordAndSelected == false && isNotInWordAndSelected == false){
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .border(.black)
                Text("\(tile.letter)")
                    .foregroundColor(.black)
                    .font(.system(size: 35))
            }//end of if statement for first thing
            else if(isInRightPosition == false && isInWordAndSelected == false && isNotInWordAndSelected == true){
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray)
                    .border(.black)
                Text("\(tile.letter)")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
            }//end of if statement for is not in word
            else if(isInRightPosition == false && isInWordAndSelected == true && isNotInWordAndSelected == false){
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.yellow)
                    .border(.black)
                Text("\(tile.letter)")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
            }//end of if statement for is in word but not right postiotion
            else if(isInRightPosition == true && isInWordAndSelected == false && isNotInWordAndSelected == false){
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.green)
                    .border(.black)
                Text("\(tile.letter)")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
            }//end of if statement for is in word and in the right position
            else{
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.red)
                    .border(.black)
                Text("\(tile.letter)")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
            }//end of all if statments, shows red if wrong
        }//end of zstack
        .frame(width: 40, height: 50)
        .onTapGesture {
            onTapOnContent?()
            print("i have been tapped")
            print("isInRightPosition: \(isInRightPosition), isInWordAndSelected: \(isInWordAndSelected), isNotInWordAndSelected: \(isNotInWordAndSelected), letter is: \(tile.letter)")
        }//end of tap gesture thing
    }
}

struct Tile{
    let letter: String
}

//#Preview {
//    LetterTileView(isInRightPosition: true, isInWordAndSelected: false, isNotInWordAndSelected: false)
//}
