//
//  ContentView.swift
//  MathGame
//
//  Created by Hanyi Ye on 2025-04-01.
//

import SwiftUI

var nums: [[Int]] = [[1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8]]

import SwiftUI


struct ClickableSquareView: View {
    @State private var borderWidth: Int = 0
    @State private var clicked: Bool = false
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .border(Color.black, width: CGFloat(borderWidth))
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
