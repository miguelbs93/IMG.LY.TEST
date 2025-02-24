import Foundation

protocol HTTPRequest {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
}

extension HTTPRequest {
    var urlRequest: URLRequest {
        var components = URLComponents(
            url: baseUrl.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        
        if let parameters = parameters {
            components?.queryItems = parameters.map {
                URLQueryItem(
                    name: $0.key,
                    value: String(describing: $0.value)
                )
            }
        }
        
        var request = URLRequest(url: components?.url ?? baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
