import Foundation

protocol NetworkingService {
    func request<T: Decodable>(_ request: HTTPRequest) async throws -> T?
}
