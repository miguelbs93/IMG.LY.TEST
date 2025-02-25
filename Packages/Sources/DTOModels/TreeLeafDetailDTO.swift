import Foundation

public struct TreeLeafDetailDTO: Decodable {
    public let createdAt: Date
    public let createdBy: String
    public let description: String
    public let id: String
    public let lastModifiedAt: Date
    public let lastModifiedBy: String
}
