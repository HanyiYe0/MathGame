import SwiftUI

// Example grid data
let nums: [[Int]] = [
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6],
    [1, 2, 3, 4, 5, 6]
]

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
                            num: .constant(nums[row][column]),
                            clicked: .constant(selectedIndices.contains(where: { $0 == index })),
                            onTap: {
                                toggleSelection(index: index)
                            }
                        )
                    }
                }
            }
        }
        .padding()
        
        if selectedIndices.count == 2 {
            
        }
    }
    
    /// Toggles the selection of a block. Only allows up to two selections.
    private func toggleSelection(index: (row: Int, column: Int)) {
        if let existingIndex = selectedIndices.firstIndex(where: { $0 == index }) {
            // Deselect the block if it's already selected.
            selectedIndices.remove(at: existingIndex)
        } else {
            // Only allow a new selection if fewer than 2 blocks are selected.
            if selectedIndices.count < 2 {
                selectedIndices.append(index)
            }
        }
    }
}

#Preview {
    ContentView()
}
