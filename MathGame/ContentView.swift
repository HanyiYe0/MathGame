//
//  ContentView.swift
//  MathGame
//
//  Created by Hanyi Ye on 2025-04-01.
//

import SwiftUI

var nums: [[Int]] = [[1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8]]

struct ContentView: View {
    var body: some View {
        VStack {
            
            ForEach(1...6, id: \.description) {_ in
                HStack {
                    ForEach(1...6, id: \.description) { _ in ClickableSquareView()}
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
