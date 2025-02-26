import Foundation

public struct TreeLeafDetailDTO: Decodable {
    public let createdAt: Date
    public let createdBy: String
    public let description: String
    public let id: String
    public let lastModifiedAt: Date
    public let lastModifiedBy: String
    
    public init(
        createdAt: Date,
        createdBy: String,
        description: String,
        id: String,
        lastModifiedAt: Date,
        lastModifiedBy: String
    ) {
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.description = description
        self.id = id
        self.lastModifiedAt = lastModifiedAt
        self.lastModifiedBy = lastModifiedBy
    }
}
