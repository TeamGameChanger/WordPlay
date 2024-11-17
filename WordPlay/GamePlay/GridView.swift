//
//  GridView.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/31/24. 🎃
//

import SwiftUI

struct GridView: View {
    @Binding var tiles: [[GridTileView]]
    @Binding var shouldShake: Bool
    @Binding var currentRow: Int

    let rows = Array(repeating: GridItem(.flexible()), count: 6)
    
    var body: some View {
        LazyHGrid(rows: rows, spacing: 5) {
            ForEach(0..<tiles.count, id: \.self) { row in
                HStack {
                    ForEach(0..<tiles[row].count, id: \.self) { col in
                        tiles[row][col]
                    }
                }
                .shake(shakes: shouldShake && row == currentRow ? 3 : 0)
                .onChange(of: shouldShake) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        shouldShake = false
                    }
                }
            }
        }
        .frame(maxHeight: 360)
    }
}

struct GridTileView: Identifiable, View {
    var letter: String
    var id = UUID()
    var backgroundColor = Color.clear
    var textColor = Color.black
    var borderColor = Color(UIColor.systemGray3)

    var body: some View {
        Text(letter)
            .bold()
            .font(.title)
            .frame(width: 50, height: 50)
            .background(backgroundColor)
            .foregroundStyle(textColor)
            .border(borderColor, width: 2)
    }
}

struct ShakeEffect: AnimatableModifier {
    var shakes: Int
    var speed: Double = 0.065
    @State var offset: CGFloat = 0

    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }

    func body(content: Content) -> some View {
            content
                .offset(x: offset)
                .onChange(of: shakes) { newValue in
                    let originalOffset = offset
                    withAnimation(
                        Animation.linear(duration: speed)
                            .repeatCount(newValue * 2, autoreverses: true)
                    ) { offset = 3 }

                    DispatchQueue.main.asyncAfter(deadline: .now() + (speed * Double(newValue * 2))) {
                        withAnimation { offset = originalOffset }
                    }
                }
        }
}

extension View {
    func shake(shakes: Int) -> some View {
        self.modifier(ShakeEffect(shakes: shakes))
    }
}
