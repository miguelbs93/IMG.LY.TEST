import Services
import NetworkManager
import DTOModels
import Foundation

// MARK: - Mock TreeDataFetcherService

final class MockTreeDataFetcherService: TreeDataFetcherServiceProtocol {
    
    var mockTreeData: [TreeNodeDTO] = []
    var mockLeafDetail: TreeLeafDetailDTO?
    var error: Error?
    var shouldThrowError: Bool = false
    
    func fetchTreeData() async throws -> [TreeNodeDTO]? {
        if shouldThrowError {
            throw NetworkError.invalidResponse(code: 500)
        }
        return mockTreeData
    }
    
    func fetchTreeLeafDetails(id: String) async throws -> TreeLeafDetailDTO? {
        if let error = error {
            throw error
        }
        return mockLeafDetail
    }
}
