import Foundation
import NetworkManager

struct TreeDataFetcherRequest: HTTPRequest {
    var path: String {
        "data.json"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var parameters: [String: Any] {
        [:]
    }
}
