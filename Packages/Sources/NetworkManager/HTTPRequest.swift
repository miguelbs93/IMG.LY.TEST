import Foundation

public protocol HTTPRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
}

public extension HTTPRequest {
    func urlRequest(with baseURL: URL) -> URLRequest {
        let components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        
        var request = URLRequest(url: components?.url ?? baseURL.appendingPathComponent(path))
        request.httpMethod = method.name
        request.allHTTPHeaderFields = headers
        
        if method == .get {
            request.url = buildURLParameters(parameters, for: request.url)
        } else {
            request.httpBody = buildBodyParameters(parameters)
        }
        return request
    }
    
    private func buildURLParameters(_ parameters: [String: Any]?, for url: URL? ) -> URL? {
        if let parameters = parameters,
           let url = url,
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?
                .replacingOccurrences(of: "+", with: "%2B")
            return urlComponents.url
        } else {
            return url
        }
    }
    
    private func buildBodyParameters(_ parameters: [String: Any]?) -> Data? {
        if let parameters = parameters {
            let json = try? JSONSerialization.data(withJSONObject: parameters)
            return json
        } else {
            return nil
        }
    }
}

public enum HTTPMethod: String {
    case delete
    case get
    case post
    case put
    
    var name: String {
        self.rawValue.uppercased()
    }
}
