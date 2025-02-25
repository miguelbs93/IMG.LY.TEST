import Foundation

public protocol NetworkingService: Sendable {
    var baseURL: URL { get }
    func request<T: Decodable>(_ request: HTTPRequest, type: T.Type) async throws -> T?
}
