import Foundation

public struct TreeNode: Encodable, Identifiable, Equatable, Hashable {
    public let children: [TreeNode]?
    public let id: String
    public let label: String
    
    public init(children: [TreeNode]?, id: String, label: String) {
        self.children = children
        self.id = id
        self.label = label
    }
}

public extension TreeNode {
    var isLeaf: Bool {
        children == nil
    }
}
