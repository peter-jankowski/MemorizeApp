//
//  EmojiMemoryGameStore.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 2/27/21.
//

import Foundation
import Combine

class EmojiMemoryGameStore: ObservableObject {
    
    @Published var themes: [Theme] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(themes) {
                UserDefaults.standard.set(encoded, forKey: "Themes")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Themes") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Theme].self, from: data) {
                self.themes = decoded
                return
            }
        }
         self.themes = [Theme.animals, Theme.sports, Theme.faces, Theme.halloween, Theme.places, Theme.vehicles]
    }
   
    let name: String = "Memorize"
    
    func makegamefor(theme: Theme) -> EmojiMemoryGame {
        return EmojiMemoryGame(theme: theme)
    }
    
    func resetThemes() {
        self.themes = [Theme.animals, Theme.sports, Theme.faces, Theme.halloween, Theme.places, Theme.vehicles]
        Theme.uniqueThemeId = 5
    }
    
    func addTheme() {
        updateUniqueId()
        let defaultcopy = Theme.defaultTheme()
        themes.append(defaultcopy)
    }
    
    func removeTheme(theme: Theme) {
        if let themeid = themes.firstIndex(matching: theme) {
            themes.remove(at: (themeid) )
        }
    }
    
    func renameTheme(theme: Theme, to: String) {
        if let themeid = themes.firstIndex(matching: theme) {
            themes[themeid].name = to
        }
    }
    
    func themeIds() -> [Int] {
        var ids = [Int]()
        for i in 0..<themes.count {
            let themeid = themes[i].id
            ids.append(themeid)
        }
        return ids
    }
    
    func updateUniqueId() {
        let maxid = themeIds().max()
        Theme.uniqueThemeId = maxid!
    }
    
    func addEmojis(theme: Theme, emojis: [String]) {
        if let themeid = themes.firstIndex(matching: theme) {
            for emoji in emojis {
                themes[themeid].emojiSet.append(emoji)
                themes[themeid].emojiSet = themes[themeid].emojiSet.unique()
            }
        }
    }
    
    func removeEmoji(theme: Theme, emoji: String) {
        if let themeid = themes.firstIndex(matching: theme) {
            let emojiset = themes[themeid].emojiSet
            themes[themeid].emojiSet = emojiset.filter { $0 != emoji}
        }
    }
    
    func plusone(theme: Theme) {
        if let themeid = themes.firstIndex(matching: theme) {
            themes[themeid].cardsNumber! += 1
        }
    }
    
    func minusone(theme: Theme) {
        if let themeid = themes.firstIndex(matching: theme) {
            themes[themeid].cardsNumber! -= 1
        }
    }
    
    func cardnumber(theme: Theme) -> Int {
        if let themeid = themes.firstIndex(matching: theme) {
            return themes[themeid].cardsNumber!
        } else {
            return 6
        }
    }
}
