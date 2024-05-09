//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Matt Wojnas on 2024-04-30.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
