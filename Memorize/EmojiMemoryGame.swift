//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-05-09.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static var theme = randomTheme()
                
    @Published private var model = createMemoryGame()
            
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: min(theme.numPairs, theme.tileSet.count)) { pairIndex in
            if theme.tileSet.indices.contains(pairIndex) {
                return theme.tileSet[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    private static func randomTheme() -> Theme<String> {
        if var randomTheme = EmojiMemoryGame.themes.randomElement() {
            randomTheme.tileSet = randomTheme.tileSet.shuffled()
            return randomTheme
        } else {
            return Theme(name: "Default", tileSet: [String](repeating: "⁉️", count: 16), numPairs: 10, color: "red")
        }
    }
    
    static var themes = [
        Theme(name: "Halloween", tileSet: ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"], numPairs: 10, color: "orange"),
        Theme(name: "Animals", tileSet: ["🦉","🐒","🦆","🦅","🐦‍⬛","🦖","🐡","🦐","🦧","🐖","🦃","🦩"], numPairs: 10, color: "purple"),
        Theme(name: "Vehicles", tileSet: ["🚙","🚑","✈️","🚢","🚀","🛵","🚲","🛸","🏎️","🚜","🚁","🚂"], numPairs: 10, color: "gray"),
        Theme(name: "Sports", tileSet: ["⛷️","🤺","🏄‍♂️","🧗‍♂️","🏋️‍♂️","⛹️‍♂️","🏌️‍♂️","🏊‍♀️","🤼‍♂️","🤸‍♂️","🚣‍♂️","🚴‍♂️"], numPairs: 10, color: "green"),
        Theme(name: "Food", tileSet: ["🥥","🍓","🌶️","🍆","🍋","🍗","🍔","🍕","🍣","🍦","🥞","🧀"], numPairs: 10, color: "brown"),
        Theme(name: "Flags", tileSet: ["🏴‍☠️","🇨🇦","🇺🇸","🇵🇱","🇸🇰","🇩🇪","🇬🇧","🇹🇹","🇬🇷","🇧🇪","🇸🇪","🇫🇷"], numPairs: 10, color: "black")
    ]
    
    private func decodeThemeColor(color: String) -> Color {
        if let themeColor = EmojiMemoryGame.colorDict[color] {
            return themeColor
        } else {
            return Color.red
        }
    }
    
    static let colorDict = ["orange": Color.orange, "purple": Color.purple, "gray": Color.gray, "green": Color.green, "brown": Color.brown, "black": Color.mint]
    
    var themeColor: Color {
        return decodeThemeColor(color: EmojiMemoryGame.theme.color)
    }
    
    var themeName: String {
        return EmojiMemoryGame.theme.name
    }
        
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    
    func newGame() {
        EmojiMemoryGame.theme = EmojiMemoryGame.randomTheme()
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
