import Foundation

class DefaultNetworkingManager: NetworkingService {
    private let session: URLSession
    private let validHTTPStatus = 200...299
    
    var baseURL: URL {
        return APIConfig.baseURL
    }
    
    init(session: URLSession) {
        self.session = session
    }
    
    func request<T: Decodable>(_ request: HTTPRequest) async throws -> T {
        let request = request.urlRequest(with: baseURL)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unkonwn
        }
        
        guard validHTTPStatus ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
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
