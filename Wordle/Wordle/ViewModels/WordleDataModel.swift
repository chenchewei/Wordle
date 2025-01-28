//
//  WordleDataModel.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

class WordleDataModel: ObservableObject {
    @Published var guesses: [Guess] = []
    @Published var incorrectAttempts: [Int] = [Int].init(repeating: 0, count: 6)
    
    var keyColors: [String: Color] = [: ]
    var selectedWord: String = ""
    var currentWord: String = ""
    var tryIndex: Int = 0
    var inPlay: Bool = false
    var gameOver: Bool = false
    
    
    var gameStarted: Bool {
        !currentWord.isEmpty || tryIndex > 0
    }
    
    var disableKeys: Bool {
        !inPlay || currentWord.count == 5
    }
    
    
    init() {
        newGame()
    }
    
    // MARK: - Settings
    func newGame() {
        populateDefaults()
        selectedWord = Global.commonWords.randomElement() ?? ""
        currentWord = ""
        inPlay = true
        gameOver = false
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
        currentWord.append(letter)
        updateRow()
    }
    
    func enterWord() {
        guard currentWord != selectedWord else {
            gameOver = true
            print("You Won")
            setCurrentGuessColors()
            inPlay = false
            return
        }
        
        if verifyWord() {
            print("Valid")
            setCurrentGuessColors()
            tryIndex += 1
            
            guard tryIndex < 6 else { return }
            gameOver = true
            inPlay = false
            print("You lost")
        } else {
            withAnimation {
                self.incorrectAttempts[tryIndex] += 1
            }
            incorrectAttempts[tryIndex] = 0
        }
    }
    
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[tryIndex].word = guessWord
    }
    
    func verifyWord() -> Bool {
        UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: currentWord)
    }
    
    func setCurrentGuessColors() {
        let correctLetters = selectedWord.map { String($0) }
        var frequency = [String : Int]()
        for letter in correctLetters {
            frequency[letter, default: 0] += 1
        }
        for index in 0...4 {
            let correctLetter = correctLetters[index]
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if guessLetter == correctLetter {
                guesses[tryIndex].bgColors[index] = .correct
                frequency[guessLetter, default: 0] -= 1
            }
        }
        
        for index in 0...4 {
            let guessLetter = guesses[tryIndex].guessLetters[index]
            if correctLetters.contains(guessLetter)
                && guesses[tryIndex].bgColors[index] != .correct
                && frequency[guessLetter, default: 0] > 0 {
                guesses[tryIndex].bgColors[index] = .misplaced
                frequency[guessLetter, default: 0] -= 1
            }
        }
        
        print(selectedWord)
        print(guesses[tryIndex].word)
    }
}
