import SwiftUI

// Original Grid Example
let originalBoard: [[Int]] = [
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6]
]

// Current board
var currentBoard: [[Int]] = originalBoard

struct ContentView: View {
    // This array tracks the selected indices (max 2 allowed).
    @State private var selectedIndices: [(row: Int, column: Int)] = []

    var body: some View {
        VStack {
            Text("Test Game")
                .font(.system(size: 50))
            
            ForEach(0..<6, id: \.self) { row in
                HStack {
                    ForEach(0..<6, id: \.self) { column in
                        let index = (row: row, column: column)
                        ClickableSquareView(
                            num: .constant(currentBoard[row][column]),
                            clicked: .constant(selectedIndices.contains(where: { $0 == index })),
                            onTap: {
                                selectionLogic(index: index)
                            }
                        )
                    }
                }
            }
            
            Button("Reset Board") {
                withAnimation {
                    currentBoard = originalBoard
                    selectedIndices.removeAll()
                }
            }.disabled(currentBoard == originalBoard)
        }
        .padding()
    }
    
    private func getLargestFactor(num1: Int, num2: Int) -> Int {
        var largestFactor = 1
        var num1Factors: [Int] = []
        for i in 1...num1 {
            if num1 % i == 0 {
                num1Factors.append(i)
            }
        }
        for factor in num1Factors {
            if num2 % factor == 0 {
                largestFactor = factor
            }
        }
        return largestFactor
    }
    
    // Does the selection logic
    private func selectionLogic(index: (row: Int, column: Int)) {
        // For selecting and deselecting elements in the table
        if let existingIndex = selectedIndices.firstIndex(where: { $0 == index }) {
            // Deselect the block if it's already selected.
            selectedIndices.remove(at: existingIndex)
        } else {
            // Only allow a new selection if fewer than 2 blocks are selected.
            if selectedIndices.count < 2 {
                selectedIndices.append(index)
            }
        }
        
        // For doing the two selection process and minimizing
        if selectedIndices.count == 2 {
            let (row1, column1) = selectedIndices[0]
            let (row2, column2) = selectedIndices[1]
            let largestFactor = getLargestFactor(num1: currentBoard[row1][column1], num2: currentBoard[row2][column2])
            currentBoard[row1][column1] = (currentBoard[row1][column1] / largestFactor)
            currentBoard[row2][column2] = currentBoard[row2][column2] / largestFactor
            
            // Clear all selections
            selectedIndices.remove(at: 0)
            selectedIndices.remove(at: 0)
        }
    }
}

#Preview {
    ContentView()
}
