//
//  LetterButtonView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

struct LetterButtonView: View {
    
    @EnvironmentObject var dataModel: WordleDataModel
    var letter: String
    
    var body: some View {
        Button {
            dataModel.addToCurrentWord(letter)
        } label: {
            Text(letter)
                .font(.system(size: 20))
                .frame(width: 35, height: 50)
                .background(dataModel.keyColors[letter])
                .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LetterButtonView(letter: "L")
        .environmentObject(WordleDataModel())
}
