import Foundation

public struct TreeNode: Decodable, Identifiable {
    public let children: [TreeNode]?
    public let id: String?
    public let label: String
}

public extension TreeNode {
    var isLeaf: Bool {
        children == nil
    }
}
