//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-05-09.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {

    private(set) var cards: Array<Card>
    
    var score = 0
    
    let startTime = Date()
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if cards[chosenIndex].firstView {
                cards[chosenIndex].timeSeen = Date()
                cards[chosenIndex].firstView = false
            }
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += max(0, 200 - 20 * (Int(min(abs(cards[chosenIndex].timeSeen.timeIntervalSinceNow), abs(cards[potentialMatchIndex].timeSeen.timeIntervalSinceNow)))/10))
                        print(Int(min(abs(cards[chosenIndex].timeSeen.timeIntervalSinceNow), abs(cards[potentialMatchIndex].timeSeen.timeIntervalSinceNow))))
                    } else {
                        if cards[chosenIndex].prevSeen { score -= 100 }
                        if cards[potentialMatchIndex].prevSeen { score -= 100 }
                        cards[chosenIndex].prevSeen = true
                        cards[potentialMatchIndex].prevSeen = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
        print(cards)
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var firstView = true
        var prevSeen = false
        var timeSeen = Date()
        var pointsEarned = 0
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")\(prevSeen ? " seen" : "")"
        }
    }
}

struct Theme<CardContent> {
    var name: String
    var tileSet: [CardContent]
    private var _numPairs: Int
    var numPairs: Int {
        get { randNumPairs ? Int.random(in: 2...tileSet.count) : _numPairs }
        set { _numPairs = newValue }
    }
    var color: String
    var colorGrad: Bool
    var randNumPairs: Bool
    
    // Need to cleanup logic for numPairs and ranNumPairs (i.e. when to "default" to randNumPairs)
    // numPairs shoud probably take precedence over randNumPairs if provided
    // maybe numPairs should default to tileSet.count
    init(name: String, tileSet: [CardContent], color: String, colorGrad: Bool = false, numPairs: Int = 0, randNumPairs: Bool = false) {
        self.name = name
        self.tileSet = tileSet
        self.color = color
        self.colorGrad = colorGrad
        self._numPairs = if randNumPairs || numPairs <= 1 {
            Int.random(in: 2...tileSet.count)
        } else {
            min(numPairs, tileSet.count)
        }
        self.randNumPairs = if numPairs <= 1 {
            true
        } else {
            randNumPairs
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
