//
//  ClickableSquare.swift
//  MathGame
//
//  Created by Hanyi Ye on 2025-04-01.
//
import SwiftUI

struct ClickableSquareView: View {
    @State private var borderWidth: CGFloat = 0
    @State public var clicked: Bool = false
    @State private var sideLength: CGFloat = 55
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: sideLength, height: sideLength)
            .border(Color.black, width: borderWidth)
            .onTapGesture {
                borderWidth = 5
                if clicked {
                    clicked = false
                    borderWidth = 0
                } else {
                    clicked = true
                    borderWidth = 5
                }
            }
    }
}


#Preview {
    ClickableSquareView()
}
