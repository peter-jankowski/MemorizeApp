//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 3/2/21.
//

import SwiftUI

struct ThemeEditor: View {
    
    @Binding var chosenTheme: Theme
    @EnvironmentObject var store: EmojiMemoryGameStore
    @Binding var cardnum: Int {
        didSet {
            if let themeid = store.themes.firstIndex(matching: chosenTheme) {
                store.themes[themeid].cardsNumber! = cardnum
            }
        }
    }
    @State private var selectedColor = "Red"
    @State private var colors: [Color] = [.red,.orange,.yellow,.green,
                                          .blue,.purple,.gray,.black]
                                 
    @State private var themename = ""
    @State private var emoji = ""
    @State private var emojis = [String]()
    @State private var maxPairs = 6

    func setcardnum() {
        if let themeid = store.themes.firstIndex(matching: chosenTheme) {
            store.themes[themeid].cardsNumber! = cardnum
            maxPairs = store.themes[themeid].emojiSet.count
        }
    }
    
    func resetMaxPairs() {
        if let themeid = store.themes.firstIndex(matching: chosenTheme) {
            if cardnum > store.themes[themeid].emojiSet.count {
                maxPairs = cardnum
            }
        }
    }
    
    func giveMaxPairs() -> Int {
        if let themeid = store.themes.firstIndex(matching: chosenTheme) {
            return store.themes[themeid].emojiSet.count
        } else {
            return 6
        }
    }

    var body: some View {
        Spacer()
        VStack {
            Text(chosenTheme.name).font(.title3)
            Form {
                Section {
                    TextField("Theme Name", text: $themename, onEditingChanged: { began in
                        if !began {
                            if !themename.isEmpty {
                                store.renameTheme(theme: chosenTheme, to: themename)
                            } else {
                                store.renameTheme(theme: chosenTheme, to: chosenTheme.name)
                            }
                        }
                    })
                }
                Section(header: Text("Add Emojis")) {
                    TextField("Emoji(s)", text: $emoji, onEditingChanged: { began in
                        if !began {
                            
                        }
                    })
                        .animation(.default)
                        .modifier(AddButton(chosenTheme: $chosenTheme,
                                          emoji: $emoji,
                                          cardnum: $cardnum))
                }
                
                Section(header: Text("Emojis")) {
                    if let themeid = store.themes.firstIndex(matching: chosenTheme) {
                        Grid(store.themes[themeid].emojiSet.map { String($0) }, id: \.self) { emoji in
                            Text(emoji)
                                .font(.largeTitle)
                                .animation(.default)
                                .onTapGesture {
                                    if store.themes[themeid].emojiSet.count > 2 {
                                        store.removeEmoji(theme: chosenTheme, emoji: emoji)
                                        setcardnum()
                                        resetMaxPairs()
                                    }
                                }
                        }.frame(minHeight: 40 * CGFloat((store.themes[themeid].emojiSet.count / 4)))
                    }
                }
                
                Section(header: Text("Card Count")) {
                    Stepper(value: $cardnum,
                            in: 2...(giveMaxPairs()),
                            step: 1)
                        { Text("\(cardnum) Pairs") }
                }
            }
            .onDisappear {
                setcardnum()
            }
        }
    }
    // MARK: - Drawing Constants
    private var cornerRadius: CGFloat = 10.0
    private var height: CGFloat = 60
}
