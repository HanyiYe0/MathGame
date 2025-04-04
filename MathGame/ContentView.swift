import SwiftUI

// Original Grid
let backupBoard: [[Int]] = [
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6]
]

let blankBoard: [[Int]] = [
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1]
]

var originalBoard: [[Int]] = generateRandomBoard()
var gameOverState: Bool = false

private func gameOverCheck() {
    if currentBoard == blankBoard {
        gameOverState = true
    }
}

private func generateRandomBoard() -> [[Int]] {
    var multiplier: Int
    var randomRow1: Int
    var randomRow2: Int
    var randomColumnn1: Int
    var randomColumnn2: Int
    var baseBoard: [[Int]] = [
        [1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1],
        [1, 1, 1, 1, 1, 1]
    ]
    while hasOnes(board: baseBoard) {
        // Generate random board
        for _ in 0...100 {
            multiplier = Int(arc4random_uniform(99) + 1)
            
            randomRow1 = Int(arc4random_uniform(6))
            randomRow2 = Int(arc4random_uniform(6))
            randomColumnn1 = Int(arc4random_uniform(6))
            randomColumnn2 = Int(arc4random_uniform(6))
            
            // If at both different numbers multiply by some random number
            if (randomRow1 != randomRow2 || randomColumnn1 != randomColumnn2) {
                let num1 = baseBoard[randomRow1][randomColumnn1]
                let num2 = baseBoard[randomRow2][randomColumnn2]
                
                // If both result in three digits or less
                if num1 * multiplier < 1000 && num2 * multiplier < 1000 {
                    baseBoard[randomRow1][randomColumnn1] = num1 * multiplier
                    baseBoard[randomRow2][randomColumnn2] = num2 * multiplier
                }
            }
        }
    }
    return baseBoard
}

func hasOnes(board: [[Int]]) -> Bool{
    var valid = false
    for row in 0...5 {
        for column in 0...5 {
            if board[row][column] == 1 {
                valid = true
            }
        }
    }
    return valid
}




// Current board
var currentBoard: [[Int]] = originalBoard

struct ContentView: View {
    // This array tracks the selected indices (max 2 allowed).
    @State private var selectedIndices: [(row: Int, column: Int)] = []

    var body: some View {
        VStack {
            Text(gameOverState ? "You Win" : "Test Game")
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
            
            HStack {
                Button("Reset Board") {
                    withAnimation {
                        currentBoard = originalBoard
                        selectedIndices.removeAll()
                    }
                }.disabled(currentBoard == originalBoard)
                
                Button("New Game") {
                    withAnimation {
                        originalBoard = generateRandomBoard()
                        currentBoard = originalBoard
                        selectedIndices.removeAll()
                    }
                }
            }
            
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
        
        // Check for game over state
        gameOverCheck()
    }
}



#Preview {
    ContentView()
}
