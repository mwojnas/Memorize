//
//  ContentView.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-04-30.
//

import SwiftUI

struct ContentView: View {
    @State var currentTheme: String = ""
    
    @State var emojis: [String] = []
    
    @State var cardCount: Int = 0
    
    @State var cardColor = Color.gray
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            //cardCountAdjusters
            themeAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatFitsBest(cardCount: cardCount)))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
    }
    
    var themeAdjusters: some View {
        HStack(alignment: .lastTextBaseline) {
            themeHalloween
                .frame(maxWidth: .infinity)
            themeVehicles
                .frame(maxWidth: .infinity)
            themeSports
                .frame(maxWidth: .infinity)
        }
        .imageScale(.large)
        .font(.body)
    }
    
    func themeAdjuster(tiles tileSet: Array<String>, label: String, symbol: String, themeColor: Color) -> some View {
        let numPairs = Int.random(in: 2...tileSet.count)
        return Button(action: {
            currentTheme = label
            emojis = (tileSet[0...numPairs-1] + tileSet[0...numPairs-1]).shuffled()
            cardCount = emojis.count
            cardColor = themeColor
        }, label: {
            VStack {
                Image(systemName: symbol)
                Text(label)
            }
        })
//        .disabled(currentTheme == label)
    }
    
    var themeHalloween: some View {
        let tileSet: [String] = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀"]
        return themeAdjuster(tiles: tileSet, label: "Halloween", symbol: "moon.fill", themeColor: Color.orange)
    }
    
    var themeVehicles: some View {
        let tileSet: [String] = ["🚙","🚑","✈️","🚢","🚀","🛵","🚲","🛸"]
        return themeAdjuster(tiles: tileSet, label: "Vehicles", symbol: "car.fill", themeColor: Color.blue)
    }
    
    var themeSports: some View {
        let tileSet: [String] = ["⛷️","🤺","🏄‍♂️","🧗‍♂️","🏋️‍♂️","⛹️‍♂️","🏌️‍♂️","🏊‍♀️"]
        return themeAdjuster(tiles: tileSet, label: "Sports", symbol: "soccerball", themeColor: Color.green)
    }
    
    func widthThatFitsBest(cardCount: Int) -> CGFloat {
        var widthGrid: Int = -5 * cardCount + 140
        if (widthGrid < 60){
            widthGrid = 60
        } else if (widthGrid > 120) {
            widthGrid = 120
        }
        return CGFloat(widthGrid)
    }
    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
