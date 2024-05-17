//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-05-09.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
                    
    @Published private var model = createMemoryGame()
            
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: EmojiGameTheme.theme.numPairs) { pairIndex in
            if EmojiGameTheme.theme.tileSet.indices.contains(pairIndex) {
                return EmojiGameTheme.theme.tileSet[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
            
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var startTime: Date {
        return model.startTime
    }
    
    // MARK: - Intents
    
    func newGame() {
        EmojiGameTheme.theme = EmojiGameTheme.randomTheme()
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

struct EmojiGameTheme {
    
    static var theme = randomTheme()
    
    static func randomTheme() -> Theme<String> {
        if var randomTheme = themes.randomElement() {
            randomTheme.tileSet = randomTheme.tileSet.shuffled()
            return randomTheme
        } else {
            return Theme(name: "Default", tileSet: [String](repeating: "⁉️", count: 16), color: "red", numPairs: 10)
        }
    }
    
    static func decodeThemeColor(color: String) -> Color {
        if let themeColor = colorDict[color] {
            return themeColor
        } else {
            return Color.red
        }
    }
    
    static var themes = [
        Theme(name: "Halloween", tileSet: ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"], color: "orange", numPairs: 50),
        Theme(name: "Animals", tileSet: ["🦉","🐒","🦆","🦅","🐦‍⬛","🦖","🐡","🦐","🦧","🐖","🦃","🦩"], color: "purple", colorGrad: true, numPairs: 2),
        Theme(name: "Vehicles", tileSet: ["🚙","🚑","✈️","🚢","🚀","🛵","🚲","🛸","🏎️","🚜","🚁","🚂"], color: "gray"),
        Theme(name: "Sports", tileSet: ["⛷️","🤺","🏄‍♂️","🧗‍♂️","🏋️‍♂️","⛹️‍♂️","🏌️‍♂️","🏊‍♀️","🤼‍♂️","🤸‍♂️","🚣‍♂️","🚴‍♂️"], color: "green", numPairs: 10, randNumPairs: true),
        Theme(name: "Food", tileSet: ["🥥","🍓","🌶️","🍆","🍋","🍗","🍔","🍕","🍣","🍦","🥞","🧀"], color: "brown", colorGrad: true, numPairs: 10),
        Theme(name: "Flags", tileSet: ["🏴‍☠️","🇨🇦","🇺🇸","🇵🇱","🇸🇰","🇩🇪","🇬🇧","🇹🇹","🇬🇷","🇧🇪","🇸🇪","🇫🇷"], color: "black", randNumPairs: true)
    ]
        
    static let colorDict = ["orange": Color.orange, "purple": Color.purple, "gray": Color.gray, "green": Color.green, "brown": Color.brown, "black": Color.mint]
    
    static var themeColor: Color {
        return EmojiGameTheme.decodeThemeColor(color: EmojiGameTheme.theme.color)
    }
    
    static var themeName: String {
        return EmojiGameTheme.theme.name
    }

}
