//
//  EmojiMemoryGameChooser.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 2/27/21.
//

import SwiftUI

struct EmojiMemoryGameChooser: View {
    
    @ObservedObject var store: EmojiMemoryGameStore
    @State private var showEditor = false
    @State private var chosenTheme = Theme.animals
    @State var cardnum: Int
    
    func howManyPairs(theme: Theme) -> String {
        if theme.cardsNumber! == theme.emojiSet.count {
            return "All of"
        } else {
            return "\(theme.cardsNumber!) pairs from"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: store.makegamefor(theme: theme))
                        .navigationBarTitle(theme.name)
                    ) {
                        HStack {
                            Image(systemName: "keyboard").imageScale(.large)
                                .onTapGesture {
                                    showEditor = true
                                    chosenTheme = theme
                                    cardnum = chosenTheme.cardsNumber!
                                }
                                .sheet(isPresented: $showEditor) {
                                    ThemeEditor(chosenTheme: $chosenTheme, cardnum: $cardnum).environmentObject(store)
                                }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(theme.name)
                                    .font(.title2)
                                    .foregroundColor(Color(theme.colorize()))
                                HStack(spacing: 0) {
                                    Text(theme.cardsNumber! == theme.emojiSet.count ? "All of" : "\(theme.cardsNumber!) pairs from")
                                        .fixedSize(horizontal: true, vertical: true)
                                    
                                    ScrollView(.horizontal, content: {
                                        HStack(spacing: 0)  {
                                            ForEach(theme.emojiSet.map { String($0) }, id: \.self) { emoji in
                                                Text(emoji)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    }
                    .animation(.easeInOut)
                }
                .onDelete { index in
                    index.map { store.themes[$0] }.forEach { theme in
                        store.removeTheme(theme: theme)
                    }
                }
            }
            .navigationBarTitle(store.name)
            .navigationBarItems(
                leading: Button(action: {
                    store.addTheme()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                })
                ,
                trailing: Button(action: {
                    store.resetThemes()
                }, label: {
                    Text("Reset")
                })
            )
        }
    }
}


