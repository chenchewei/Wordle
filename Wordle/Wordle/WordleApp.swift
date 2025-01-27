//
//  WordleApp.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

@main
struct WordleApp: App {
    
    @StateObject var dataModel = WordleDataModel()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dataModel)
        }
    }
}
