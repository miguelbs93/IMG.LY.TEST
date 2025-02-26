import Foundation

public struct TreeNodeDTO: Decodable {
    public let children: [TreeNodeDTO]?
    public let id: String?
    public let label: String
    
    public init(children: [TreeNodeDTO]?, id: String?, label: String) {
        self.children = children
        self.id = id
        self.label = label
    }
}
