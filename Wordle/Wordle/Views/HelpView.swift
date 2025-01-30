//
//  HelpView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/30.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(
"""
Guess the **WORDLE** in 6. tries.

Each guess must be a valid 5 letter word.  Hit the enter button to submit.

After each guess, the color of the tiles will change to show how close your guess was to the word.
"""
                )
                Divider()
                
                Text("Examples")
                    .font(.headline)
                    .fontWeight(.semibold)
                VStack(alignment: .leading) {
                    Image(.weary)
                        .resizable()
                        .scaledToFit()
                    Text("The letter **W** is in the word and in the correct spot.")
                    Image("Pills")
                        .resizable()
                        .scaledToFit()
                    Text("The letter **I** is in the word but in the wrong spot.")
                    Image("Vague")
                        .resizable()
                        .scaledToFit()
                    Text("The letter **U** is not in the word in any spot.")
                }
                
                Divider()
                
                Text("**Tap the New button on the top left to start a new game!**")
                Spacer()
            }
            .frame(width: min(Global.screenWidth - 40, 350))
            .navigationTitle("How to Play")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
        
    }
}

#Preview {
    HelpView()
}
