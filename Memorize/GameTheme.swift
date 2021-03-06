//
//  GameTheme.swift
//  Memorize
//
//  Created by Peter A. Jankowski on 1/21/21.
//

import Foundation
import SwiftUI

struct Theme: Codable, Identifiable {
    var name: String
    var emojiSet: [String]
    var cardsNumber: Int?
    var color: UIColor.RGB
    var id: Int
    
    func colorize() -> UIColor {
        return UIColor(color)
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static let animals = Theme(name: "Animals", emojiSet: ["πΆ","π¦","π¦","πΉ","π¨","πΈ"],
                               cardsNumber: 6, color: (UIColor(.red)).rgb, id: 0)
    static let sports = Theme(name: "Sports", emojiSet: ["β½οΈ","π","π","βΎοΈ","πΎ","π"],
                              cardsNumber: 6, color: (UIColor(.blue)).rgb, id: 1)
    static let faces = Theme(name: "Faces", emojiSet: ["π₯Ί","π₯΅","π₯Ά","π€ ","π","π€―"],
                             cardsNumber: 6, color: (UIColor(.yellow)).rgb, id: 2)
    static let halloween = Theme(name: "Halloween", emojiSet: ["π»","π","π·","π€‘","π€","β οΈ"],
                                 cardsNumber: 6, color: (UIColor(.orange)).rgb, id: 3)
    static let places = Theme(name: "Places", emojiSet: ["π°","π","π‘","π","π","π","π ","π­","π"],
                              cardsNumber: 6, color: (UIColor(.purple)).rgb, id: 4)
    static let vehicles = Theme(name: "Vehicles", emojiSet: ["βοΈ","π","πΆ","π","π’","π","πΊ","π΅","π"],
                                cardsNumber: 6, color: (UIColor(.black)).rgb, id: 5)
    
    static func defaultTheme() -> Theme {
        let defaultTheme = Theme(name: "Untitled", emojiSet: ["π","β€οΈ","π","π","π","π₯"],  cardsNumber: 6, color: (UIColor(.green)).rgb, id: Theme.themeId())
        return defaultTheme
    }

    static var uniqueThemeId = 5
    
    static func themeId() -> Int {
        uniqueThemeId += 1
        return uniqueThemeId
    }

    static let themes = [animals, sports, faces, halloween, places, vehicles]
    
}
