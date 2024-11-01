//
//  GridView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/31/24. 🎃
//

import SwiftUI

struct GridView: View {
    @Binding var tiles: [[GridTileView]]

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
