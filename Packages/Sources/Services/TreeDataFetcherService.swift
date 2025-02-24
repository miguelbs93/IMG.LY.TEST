import NetworkingManager
import DTOModels
import Foundation

public protocol TreeDataFetcherServiceProtocol {
    func fetchTreeData() async throws -> [TreeNode]?
    func fetchTreeLeafDetails(id: String) async throws  -> TreeLeafDetail?
}

public struct TreeDataFetcherService: TreeDataFetcherServiceProtocol {
    
    private let networkManager: NetworkingService
    
    // MARK: - Init
    
    public init(networkManager: NetworkingService) {
        self.networkManager = networkManager
    }
    
    public func fetchTreeData() async throws -> [TreeNode]? {
        let request = TreeDataFetcherRequest()
        
        var nodes: [TreeNode]?
        
        do {
            nodes = try await networkManager.request(request, type: [TreeNode].self)
        } catch {
            throw error
        }
        
        return nodes
    }
    
    public func fetchTreeLeafDetails(id: String) async throws -> TreeLeafDetail? {
        let request = TreeLeafDataRequest(id: id)
        var detail: TreeLeafDetail?
        
        do {
            detail = try await networkManager.request(request, type: TreeLeafDetail.self)
        } catch {
            print("error :\(error)")
        }
        
        return detail
    }
}




