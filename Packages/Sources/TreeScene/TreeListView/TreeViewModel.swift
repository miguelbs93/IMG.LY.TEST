import DTOModels
import Models
import Foundation
import Services
import NetworkManager

final class TreeViewModel: ObservableObject {
    private let networkManager: NetworkService
    private let service: TreeDataFetcherServiceProtocol
    
    @Published var nodes: [TreeNode] = []
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        self.service = TreeDataFetcherService(networkManager: networkManager)
        Task {
            try? await fetchData()
        }
    }
    
    @MainActor
    private func fetchData() async throws {
        var dtoNodes: [TreeNodeDTO] = []
        
        do {
            dtoNodes = try await self.service.fetchTreeData() ?? []
            DispatchQueue.main.async {
                self.nodes = dtoNodes.map(TreeNode.getNode)
            }
        } catch {
            print("error fetching data: \(error)")
        }
    }
}

// MARK: - TreeNode

extension TreeNode {
    static func getNode(_ dto: TreeNodeDTO) -> TreeNode {
        TreeNode(
            children: dto.children?.map(TreeNode.getNode),
            id: dto.id ?? UUID().uuidString,
            label: dto.label
        )
        
    }
}
