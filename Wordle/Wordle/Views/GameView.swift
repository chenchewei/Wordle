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
            Spacer()
            VStack(spacing: 3, content: {
                ForEach(0...5, id: \.self) { index in
                    GuessView(guess: $dataModel.guesses[index])
                        .modifier(Shake(animatableData: CGFloat(dataModel.incorrectAttempts[index])))
                }
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
                    Text("WORDLE")
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
            
            Spacer()
            
            Keyboard()
                .scaleEffect(Global.keyboardScale)
                .padding(.top)
            
            Spacer()
        }
    }
}

#Preview {
    GameView()
        .environmentObject(WordleDataModel())
}
