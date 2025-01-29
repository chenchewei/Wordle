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
    @Published var toastText: String?
    @Published var showStats: Bool = false
    
    var keyColors: [String: Color] = [: ]
    var matchedLetters = [String]()
    var misplacedLetters = [String]()
    var selectedWord: String = ""
    var currentWord: String = ""
    var attemptCount: Int = 0
    var inPlay: Bool = false
    var gameOver: Bool = false
    let winToasts: [String] = ["Uncanny", "Magnificent", "Impressive", "Wicked", "Cool", "Phew"]
    var currentStatistic: Statistic = Statistic.loadStat()
    
    var gameStarted: Bool {
        !currentWord.isEmpty || attemptCount > 0
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
        attemptCount = 0
        print("selectedWord: \(selectedWord)")
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
            setCurrentGuessColors()
            inPlay = false
            showToast(with: winToasts[attemptCount])
            currentStatistic.update(win: true, index: attemptCount)
            return
        }
        
        if verifyWord() {
            print("Valid")
            setCurrentGuessColors()
            attemptCount += 1
            currentWord = ""
            guard attemptCount > 5 else { return }
            gameOver = true
            inPlay = false
            currentStatistic.update(win: false)
            showToast(with: "The answer is: \(selectedWord)")
        } else {
            withAnimation {
                self.incorrectAttempts[attemptCount] += 1
            }
            showToast(with: "Not in word list.")
            incorrectAttempts[attemptCount] = 0
        }
    }
    
    func removeLetterFromCurrentWord() {
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow() {
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[attemptCount].word = guessWord
    }
    
    private func verifyWord() -> Bool {
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
            let guessLetter = guesses[attemptCount].guessLetters[index]
            if guessLetter == correctLetter {
                guesses[attemptCount].bgColors[index] = .correct
                if !matchedLetters.contains(guessLetter) {
                    matchedLetters.append(guessLetter)
                    keyColors[guessLetter] = .correct
                }
                if misplacedLetters.contains(guessLetter) {
                    if let index = misplacedLetters.firstIndex(where: {$0 == guessLetter}) {
                        misplacedLetters.remove(at: index)
                    }
                }
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...4 {
            let guessLetter = guesses[attemptCount].guessLetters[index]
            if correctLetters.contains(guessLetter)
                && guesses[attemptCount].bgColors[index] != .correct
                && frequency[guessLetter]! > 0 {
                guesses[attemptCount].bgColors[index] = .misplaced
                if !misplacedLetters.contains(guessLetter) && !matchedLetters.contains(guessLetter) {
                    misplacedLetters.append(guessLetter)
                    keyColors[guessLetter] = .misplaced
                }
                frequency[guessLetter]! -= 1
            }
        }
        
        for index in 0...4 {
            let guessLetter = guesses[attemptCount].guessLetters[index]
            if keyColors[guessLetter] != .correct
                && keyColors[guessLetter] != .misplaced {
                keyColors[guessLetter] = .wrong
            }
        }
        flipCards(for: attemptCount)
    }
    
    func flipCards(for row: Int) {
        for col in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(col) * 0.2) {
                self.guesses[row].cardFlipped[col].toggle()
            }
        }
    }
    
    // MARK: - Toast
    func showToast(with text: String?) {
        withAnimation {
            toastText = text
        }
        withAnimation(Animation.linear(duration: 0.2).delay(3)) {
            toastText = nil
            
            guard gameOver else { return }
            withAnimation(Animation.linear(duration: 0.2).delay(3)) {
                showStats.toggle()
            }
        }
    }
}
