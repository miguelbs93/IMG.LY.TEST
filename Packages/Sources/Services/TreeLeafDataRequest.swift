import Foundation
import NetworkingManager

struct TreeLeafDataRequest: HTTPRequest {
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var path: String {
        "entries/\(id).json"
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
