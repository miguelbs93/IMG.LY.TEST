import Foundation

public struct APIConfig {
    public static let baseURL: URL = {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("BASE_URL is missing")
        }
        return url
    }()
}
