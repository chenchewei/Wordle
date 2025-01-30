//
//  ContentView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dataModel: WordleDataModel
    @State private var showSettings: Bool = false
    
    var body: some View {
        ZStack {
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
                .disabled(dataModel.showStats)
                .overlay(alignment: .top, content: {
                    if let toastText = dataModel.toastText {
                        ToastView(toastText: toastText)
                            .offset(y: 20)
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            if !dataModel.inPlay {
                                Button {
                                    dataModel.newGame()
                                } label: {
                                    Text("New")
                                        .foregroundStyle(.primary)
                                }
                            }
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
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
                                withAnimation {
                                    dataModel.showStats.toggle()
                                }
                            } label: {
                                Image(systemName: "chart.bar")
                            }
                            Button {
                                showSettings.toggle()
                            } label: {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                        
                    }
                }
                .disabled(dataModel.showStats)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            
            if dataModel.showStats {
                StatsView()
            }
        }
        Spacer()
        
        Keyboard()
            .scaleEffect(Global.keyboardScale)
            .padding(.top)
            .disabled(dataModel.showStats)
        
        Spacer()
    }
}

#Preview {
    GameView()
        .environmentObject(WordleDataModel())
}
