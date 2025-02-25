import Foundation

public class DefaultNetworkingManager: NetworkService, @unchecked Sendable {
    private let session: URLSession
    private let validHTTPStatus = 200...299
    private let decoder: JSONDecoder
    
    public var baseURL: URL {
        return APIConfig.baseURL
    }
    
    public init(
        decoder: JSONDecoder = .init(),
        session: URLSession = .shared
    ) {
        self.decoder = decoder
        self.session = session
    }
    
    public func request<T>(_ request: any HTTPRequest, type: T.Type) async throws -> T? where T : Decodable {
        let request = request.urlRequest(with: baseURL)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unkonwn
        }
        
        guard validHTTPStatus ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

// MARK: - Network Error

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case unkonwn
}
