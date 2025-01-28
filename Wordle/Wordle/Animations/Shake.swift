//
//  Shake.swift
//  Wordle
//
//  Created by Anderson Chen on 2025/1/28.
//

import SwiftUI

/// Reference: https://www.objc.io/blog/2019/10/01/swiftui-shake-animation/

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}
