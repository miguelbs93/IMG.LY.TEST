import Foundation

public struct TreeNode: Decodable {
    let children: [TreeNode]?
    let id: String?
    let label: String
}

public extension TreeNode {
    var isLeaf: Bool {
        children == nil
    }
}
