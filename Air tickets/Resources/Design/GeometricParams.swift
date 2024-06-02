
import Foundation

struct GeometricParams {
    let cellSize: CGSize
    let leftInset: CGFloat
    let rightInset: CGFloat
    let cellSpacing: CGFloat

    init(cellSize: CGSize, leftInset: CGFloat, rightInset: CGFloat, cellSpacing: CGFloat) {
        self.cellSize = cellSize
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.cellSpacing = cellSpacing
    }
}
