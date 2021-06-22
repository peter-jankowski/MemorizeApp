//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 1/4/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let store = EmojiMemoryGameStore()
            EmojiMemoryGameChooser(store: store, cardnum: 6)
        }
    }
}
