//
//  ContentView.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-04-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: false)
            CardView()
            CardView(isFaceUp: true)
            CardView(isFaceUp: true)
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
