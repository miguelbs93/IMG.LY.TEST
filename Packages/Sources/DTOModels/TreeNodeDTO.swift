import Foundation

public struct TreeNodeDTO: Decodable {
    public let children: [TreeNodeDTO]?
    public let id: String?
    public let label: String
}
