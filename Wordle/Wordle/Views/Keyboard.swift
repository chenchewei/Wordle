//
//  Keyboard.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/27.
//

import SwiftUI

struct Keyboard: View {
    
    @EnvironmentObject var dataModel: WordleDataModel
 
    var topRowArray: [String] = "QWERTYUIOP".map { String($0) }
    var secondRowArray: [String] = "ASDFGHJKL".map { String($0) }
    var thirdRowArray: [String] = "ZXCVBNM".map { String($0) }
    
    var body: some View {
        VStack {
            HStack(spacing: 2, content: {
                ForEach(topRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
            })
            
            HStack(spacing: 2, content: {
                ForEach(secondRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
            })
            
            HStack(spacing: 2, content: {
                Button {
                    dataModel.enterWord()
                } label: {
                    Text("Enter")
                }
                .font(.system(size: 20))
                .frame(width: 60, height: 50)
                .foregroundStyle(.primary)
                .background(Color.unused)
                
                ForEach(thirdRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                
                Button {
                    dataModel.removeLetterFromCurrentWord()
                } label: {
                    Image(systemName: "delete.backward.fill")
                }
                .font(.system(size: 20, weight: .heavy))
                .frame(width: 40, height: 50)
                .foregroundStyle(.primary)
                .background(Color.unused)
            })
            
            
        }
    }
}

#Preview {
    Keyboard()
        .environmentObject(WordleDataModel())
        .scaleEffect(Global.keyboardScale)
}
