//
//  GridView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/31/24. 🎃
//

import SwiftUI

struct GridView: View {
    @State var tiles: [[GridTileView]] = Array(repeating: Array(repeating: GridTileView(letter: ""), count: 5), count: 6)
    @State var inputtedWords: [String] = []
    @State var currentWord: String = ""
    @State var currentRow = 0
    let targetWord = "BUNNY" // TODO: replace with word of the day
    let rows = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        LazyHGrid(rows: rows, spacing: 5) {
            ForEach(0..<tiles.count, id: \.self) { row in
                HStack {
                    ForEach(0..<tiles[row].count, id: \.self) { col in
                        tiles[row][col]
                    }
                }
            }
        }
        .frame(maxHeight: 400)
        
        TextField("Word Input", text: $currentWord) // TODO: replace with input from custom keyboard
            .textFieldStyle(.roundedBorder)
            .frame(width: 275)
            .padding()
            .onChange(of: currentWord) {
                // truncate input to 5 letters, update later
                if currentWord.count > 5 {
                    currentWord = String(currentWord.prefix(5))
                }
                
                currentWord = currentWord.uppercased()
        
                for index in 0..<tiles[currentRow].count {
                    if index < currentWord.count {
                        tiles[currentRow][index].letter = String(currentWord[index])
                    } else {
                        tiles[currentRow][index].letter = ""
                    }
                }
            }
        
        Button("Submit") {
            if currentWord == targetWord {
                print("Game win")
                // TODO: Trigger game end code
            }

            // TODO: Check if input is a valid word
            // TODO: Update colors of tiles based on correctness

            inputtedWords.append(currentWord)
            currentRow += 1
            currentWord = ""
        }
        .buttonStyle(.borderedProminent)
    }
}

struct GridTileView: Identifiable, View {
    var letter: String
    var id = UUID()

    var body: some View {
        Text(letter)
            .bold()
            .frame(width: 50, height: 50)
            .border(Color.gray)
    }
}

#Preview {
    GridView()
}
