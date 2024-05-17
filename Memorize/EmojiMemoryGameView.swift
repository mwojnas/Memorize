//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-04-30.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            VStack {
                HStack {
                    Text(EmojiGameTheme.themeName)
                        .font(.largeTitle)
                    Spacer()
                    Text("Score: \(viewModel.score)")
                        .font(.largeTitle)
                }
                VStack {
                    Button("New Game") {
                        viewModel.newGame()
                    }
                    .fontWeight(.bold)
                    Text(viewModel.startTime, style: .timer)
                }

            }
        }
        .padding()
    }
    
    var cards: some View {

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(5)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
            }
        }
    }
}

struct CardView: View {

    let card: MemoryGame<String>.Card
    
    let themeColor = EmojiGameTheme.themeColor
    
    let themeColorGrad = EmojiGameTheme.theme.colorGrad
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                if themeColorGrad {
                    base.strokeBorder(themeColor.gradient, lineWidth: 2)
                } else {
                    base.strokeBorder(themeColor, lineWidth: 2)
                }
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            if themeColorGrad {
                base.fill(themeColor.gradient).opacity(card.isFaceUp ? 0 : 1)
            } else {
                base.fill(themeColor).opacity(card.isFaceUp ? 0 : 1)

            }
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
