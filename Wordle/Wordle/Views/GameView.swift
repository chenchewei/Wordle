//
//  ContentView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dataModel: WordleDataModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 3, content: {
                GuessView(guess: $dataModel.guesses[0])
                GuessView(guess: $dataModel.guesses[1])
                GuessView(guess: $dataModel.guesses[2])
                GuessView(guess: $dataModel.guesses[3])
                GuessView(guess: $dataModel.guesses[4])
                GuessView(guess: $dataModel.guesses[5])
            })
            .frame(width: Global.boardWidth, height: 6 * Global.screenWidth / 5)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("WODLE")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundStyle(.primary)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "chart.bar")
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    GameView()
        .environmentObject(WordleDataModel())
}
