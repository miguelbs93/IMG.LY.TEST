import Foundation

protocol NetworkingService {
    var baseURL: URL { get }
    func request<T: Decodable>(_ request: HTTPRequest) async throws -> T?
}
