//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-05-09.
//

import Foundation


struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
