import Foundation

public protocol NetworkingService {
    var baseURL: URL { get }
    func request<T: Decodable>(_ request: HTTPRequest, type: T.Type) async throws -> T?
}
