//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 1/4/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    var theme: Theme
    var model: MemoryGame<String> {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {

        let emojis = theme.emojiSet
        
        func randnumgen(theme: Theme) -> Int {
            if let number = theme.cardsNumber {
                return min(number, theme.emojiSet.count)
                }
            else {
                return theme.emojiSet.count
            }
        }
        let randomnum = randnumgen(theme: theme)
        
        return MemoryGame<String>(numberOfPairsOfCards: randomnum, theme: theme) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func setTheme(theme: Theme) {
        model.theme = theme
    }
    
    func resetGame(theme: Theme) {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func initGame(theme: Theme) -> MemoryGame<String> {
        return EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
