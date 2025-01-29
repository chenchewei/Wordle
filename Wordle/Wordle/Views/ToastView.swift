//
//  ToastView.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/29.
//

import SwiftUI

struct ToastView: View {
    let toastText: String
    
    var body: some View {
        Text(toastText)
            .foregroundStyle(Color(UIColor.systemBackground))
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.primary))
    }
}

#Preview {
    ToastView(toastText: "Not in word list")
}
