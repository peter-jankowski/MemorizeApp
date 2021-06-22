//
//  AddButton.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 3/2/21.
//

import SwiftUI

struct AddButton: ViewModifier {
    @Binding var chosenTheme: Theme
    @EnvironmentObject var store: EmojiMemoryGameStore
    @Binding var emoji: String
    @Binding var cardnum: Int
    var emojis = [String]()
    
    func setcardnum() {
        if let themeid = store.themes.firstIndex(matching: chosenTheme) {
            store.themes[themeid].cardsNumber! = cardnum
        }
    }
    
    func convertEmojis(emoji: String) -> [String]{
        var emojis = [String]()
        for emoji in emoji {
            emojis.append(String(emoji))
            emojis = emojis.filter { $0 != "."}
            emojis = emojis.filter { $0 != " "}
        }
        return emojis
    }
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !emoji.isEmpty {
                Button(
                    action: {
                        let emojis = convertEmojis(emoji: emoji)
                        store.addEmojis(theme: chosenTheme, emojis: emojis)
                        setcardnum()
                    }, label: {
                        Text("Add")
                    }
                )
                .animation(.default)
            }
        }
    }
}
