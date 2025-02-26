import DTOModels
import Models
import Foundation
import Services
import NetworkManager

class TreeViewModel: ObservableObject {
    private let networkManager: NetworkService
    private let service: TreeDataFetcherServiceProtocol
    
    @Published var nodes: [TreeNode] = []
    @Published var isLoading: Bool = false
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        self.service = TreeDataFetcherService(networkManager: networkManager)
        Task {
            try? await fetchData()
        }
    }
    
    /// Fetches tree data asynchronously from the service and updates the nodes.
    /// - Throws: An error if the network request fails.
    @MainActor
    func fetchData() async throws {
        var dtoNodes: [TreeNodeDTO] = []
        isLoading = true
        
        do {
            dtoNodes = try await self.service.fetchTreeData() ?? []
            DispatchQueue.main.async {
                self.nodes = dtoNodes.map(TreeNode.getNode)
            }
        } catch {
            print("error fetching data: \(error)")
        }
        
        isLoading = false
    }
}

// MARK: - Delete/Move Nodes
extension TreeViewModel {
    func deleteItem(at offsets: IndexSet) {
        nodes.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        nodes.move(fromOffsets: source, toOffset: destination)
    }
}

// MARK: - TreeNode

extension TreeNode {
    /// This method that  returns TreeNode Model from the TreeNodeDTO
    static func getNode(_ dto: TreeNodeDTO) -> TreeNode {
        TreeNode(
            children: dto.children?.map(TreeNode.getNode),
            id: dto.id ?? UUID().uuidString,
            label: dto.label
        )
        
    }
}
