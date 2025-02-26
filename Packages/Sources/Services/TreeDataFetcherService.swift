import NetworkManager
import DTOModels
import Foundation

public protocol TreeDataFetcherServiceProtocol {
    func fetchTreeData() async throws -> [TreeNodeDTO]?
    func fetchTreeLeafDetails(id: String) async throws  -> TreeLeafDetailDTO?
}

public struct TreeDataFetcherService: TreeDataFetcherServiceProtocol {
    
    private let networkManager: NetworkService
    
    // MARK: - Init
    
    public init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    public func fetchTreeData() async throws -> [TreeNodeDTO]? {
        let request = TreeDataFetcherRequest()
        
        var nodes: [TreeNodeDTO]?
        
        do {
            nodes = try await networkManager.request(request, type: [TreeNodeDTO].self)
        } catch {
            throw error
        }
        
        return nodes
    }
    
    public func fetchTreeLeafDetails(id: String) async throws -> TreeLeafDetailDTO? {
        let request = TreeLeafDataRequest(id: id)
        var detail: TreeLeafDetailDTO?
        
        do {
            detail = try await networkManager.request(request, type: TreeLeafDetailDTO.self)
        } catch {
            throw error
        }
        
        return detail
    }
}




