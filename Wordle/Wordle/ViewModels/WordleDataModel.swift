//
//  WordleDataModel.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    
    var keyColors: [String: Color] = [: ]
    
    init() {
        newGame()
    }
    
    // MARK: - Settings
    func newGame() {
        populateDefaults()
    }
    
    func populateDefaults() {
        guesses = []
        
        for index in 0...5 {
            guesses.append(Guess(index: index))
        }
        
        // Reset keyboards
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors["\(char)"] = .unused
        }
    }
    
    // MARK: - Game Play Logic
    func addToCurrentWord(_ letter: String) {
        
    }
    
    func enterWord() {
        
    }
    
    func removeLetterFromCurrentWord() {
        
    }
}
