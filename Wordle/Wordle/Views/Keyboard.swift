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
                .disabled(dataModel.disableKeys)
                .opacity(dataModel.disableKeys ? 0.6 : 1)
            })
            
            HStack(spacing: 2, content: {
                ForEach(secondRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dataModel.disableKeys)
                .opacity(dataModel.disableKeys ? 0.6 : 1)
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
                .disabled(dataModel.currentWord.count < 5 || !dataModel.inPlay)
                .opacity((dataModel.currentWord.count < 5 || !dataModel.inPlay) ? 0.6 : 1)
                
                ForEach(thirdRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                }
                .disabled(dataModel.disableKeys)
                .opacity(dataModel.disableKeys ? 0.6 : 1)
                
                Button {
                    dataModel.removeLetterFromCurrentWord()
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .font(.system(size: 20, weight: .heavy))
                        .frame(width: 40, height: 50)
                        .foregroundStyle(.primary)
                        .background(Color.unused)
                }
                .disabled(!dataModel.inPlay || dataModel.currentWord.isEmpty)
                .opacity((!dataModel.inPlay || dataModel.currentWord.isEmpty) ? 0.6 : 1)
            })
            
            
        }
    }
}

#Preview {
    Keyboard()
        .environmentObject(WordleDataModel())
        .scaleEffect(Global.keyboardScale)
}
