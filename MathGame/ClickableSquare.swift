//
//  ClickableSquare.swift
//  MathGame
//
//  Created by Hanyi Ye on 2025-04-01.
//
import SwiftUI

struct ClickableSquareView: View {
    @State private var borderWidth: CGFloat = 0
    @State  var sideLength: CGFloat = 55
    @Binding public var num: Int
    @Binding public var clicked: Bool
    var onTap: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: sideLength, height: sideLength)
                .border(Color.black, width: clicked ? 5 : 0)
                .onTapGesture {
                    onTap()
                }
                .opacity(num == 1 ? 0 : 1)
            
            Text(String(num)).opacity(num == 1 ? 0 : 1)
        }
        
    }
}
