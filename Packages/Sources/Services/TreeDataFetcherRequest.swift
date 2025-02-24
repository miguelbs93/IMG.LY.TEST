import Foundation
import NetworkingManager

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
