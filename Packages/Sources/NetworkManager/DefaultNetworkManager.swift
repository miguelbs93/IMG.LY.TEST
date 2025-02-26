import Foundation

public class DefaultNetworkManager: NetworkService {
    private let session: URLSession
    private let validHTTPStatus = 200...299
    private let decoder: JSONDecoder
    
    public var baseURL: URL {
        return APIConfig.baseURL
    }
    
    public init(
        decoder: JSONDecoder = .customDecoder,
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
            throw NetworkError.invalidResponse(code: response.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

// MARK: - Network Error

public enum NetworkError: Error {
    case invalidResponse(code: Int)
    case decodingError
    case unkonwn
}

// MARK: - JSONDecoder

extension JSONDecoder {
    public static let customDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX" // Supports milliseconds and timezone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
}
