//
//  StatsView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/29.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var dataModel: WordleDataModel
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        dataModel.showStats.toggle()
                    }
                } label: {
                    Image(systemName: "x.circle")
                        .tint(.pink)
                }
                .offset(x: 20, y: 10)
            }
            
            Text("STATISTIC")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(alignment: .top) {
                SingleStatView(value: dataModel.currentStatistic.games, text: "Played")
                SingleStatView(value: dataModel.currentStatistic.winRate, text: "Win %")
                SingleStatView(value: dataModel.currentStatistic.streak, text: "Current Streak")
                    .fixedSize(horizontal: false, vertical: true)
                SingleStatView(value: dataModel.currentStatistic.maxStreak, text: "Max Streak")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Text("GUESS DISTRIBUTION")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack(spacing: 5) {
                ForEach (0..<6, id: \.self) { index in
                    StatBarView(index: index)
                        .environmentObject(dataModel)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
        .frame(width: 320, height: 370)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemBackground)))
        .padding()
        .shadow(radius: 10)
        .offset()
    }
}

#Preview {
    StatsView()
        .environmentObject(WordleDataModel() )
}

// MARK: - Single Stat View
struct SingleStatView: View {
    let value: Int
    let text: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(value)")
                .font(.largeTitle)
            
            Text(text)
                .font(.caption)
                .frame(width: 50)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Stat Bar View
struct StatBarView: View {
    @EnvironmentObject var dataModel: WordleDataModel
    let index: Int
    var body: some View {
        HStack {
            Text("\(index + 1)")
            
            if dataModel.currentStatistic.frequencies[index] == 0 {
                Rectangle()
                    .fill(.wrong)
                    .frame(width: 22, height: 20)
                    .overlay {
                        Text("0")
                            .foregroundStyle(.white)
                    }
            } else {
                if let maxValue = dataModel.currentStatistic.frequencies.max() {
                    Rectangle()
                        .fill(dataModel.attemptCount == index && dataModel.gameOver ? .correct : .wrong)
                        .frame(width: CGFloat(dataModel.currentStatistic.frequencies[index]) / CGFloat(maxValue) * 210, height: 20)
                        .overlay (
                            Text("\(dataModel.currentStatistic.frequencies[index])")
                                .foregroundStyle(.white)
                                .padding(.horizontal, 5),
                            alignment: .trailing
                        )
                }
            }
            
            Spacer()
        }
    }
}
