//
//  Statistic.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/29.
//

import Foundation

struct Statistic: Codable {
    var frequencies = [Int](repeating: 0, count: 6)
    var games: Int = 0
    var streak: Int = 0
    var maxStreak: Int = 0
    
    var wins: Int {
        frequencies.reduce(0, +)
    }
    
    var winRate: Int {
        if games > 0 {
            return (100 * wins / games)
        } else {
            return 0
        }
    }
    
    func saveStat() {
        guard let encoded = try? JSONEncoder().encode(self) else { return }
        
        UserDefaults.standard.set(encoded, forKey: "Stat")
        UserDefaults.standard.synchronize()
    }
    
    static func loadStat() -> Statistic {
        guard let savedStat = UserDefaults.standard.object(forKey: "Stat") as? Data,
              let currentStat = try? JSONDecoder().decode(Statistic.self, from: savedStat) else {
            return Statistic()
        }
        
        return currentStat
    }
    
    mutating func update(win: Bool, index: Int? = nil) {
        games += 1
        streak = win ? streak + 1 : 0
        if win, let index {
            frequencies[index] += 1
            maxStreak = max(maxStreak, streak)
        }
        saveStat()
    }
}
