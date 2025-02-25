import DTOModels
import Models
import Foundation
import Services
import NetworkManager

class TreeViewModel: ObservableObject {
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
    
    func deleteItem(at offsets: IndexSet, in parentNode: TreeNode? = nil) {
        if let parentNode = parentNode {
            parentNode.children?.remove(atOffsets: offsets)
        } else {
            nodes.remove(atOffsets: offsets)
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int, in parentNode: TreeNode? = nil) {
        if let parentNode = parentNode {
            parentNode.children?.move(fromOffsets: source, toOffset: destination)
        } else {
            nodes.move(fromOffsets: source, toOffset: destination)
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
