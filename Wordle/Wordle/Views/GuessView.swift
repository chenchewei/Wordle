//
//  GuessView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

struct GuessView: View {
    @Binding var guess: Guess
    
    var body: some View {
        HStack(spacing: 3,
               content: {
            ForEach(0...4, id: \.self) { index in
                Text(guess.guessLetters[index])
                    .foregroundStyle(.primary)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .background(Color(UIColor.systemBackground))
                    .font(.system(size: 35, weight: .heavy))
                    .border(Color.secondary)
            }
        })
    }
}

#Preview {
    GuessView(guess: .constant(Guess(index: 0)))
}
