//
//  Guess.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

struct Guess {
    let index: Int
    var word: String = "     "
    var bgColors: [Color] = [Color].init(repeating: .wrong, count: 5)
    var cardFlipped: [Bool] = [Bool].init(repeating: false, count: 5)
    var guessLetters: [String] {
        word.map { String($0) }
    }
    
    var results: String {
        let tryColors: [Color: String] = [.misplaced: "🟨",
                                          .correct: "🟩",
                                          .wrong: "⬛️"]
        return bgColors.compactMap { tryColors[$0] }.joined(separator: "")
    }
}
