//
//  ContentView.swift
//  MathGame
//
//  Created by Hanyi Ye on 2025-04-01.
//

import SwiftUI

var nums: [[Int]] = [
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6]
]

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Test Game").font(.system(size: 50))
            
            ForEach(0..<6, id: \.self) {row in
                HStack {
                    ForEach(0..<6, id: \.self) { column in
                        ClickableSquareView(num: .constant(nums[row][column]))
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
