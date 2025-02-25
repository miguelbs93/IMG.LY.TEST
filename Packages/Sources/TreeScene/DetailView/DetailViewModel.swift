import Foundation
import Services
import DTOModels
import Models

final class DetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var leafDetails: TreeLeafDetailDTO?
    
    private let leaf: TreeNode
    private let service: TreeDataFetcherServiceProtocol
    
    var title: String {
        leaf.label
    }
    
    init(
        leaf: TreeNode,
         service: TreeDataFetcherServiceProtocol
    ) {
        self.leaf = leaf
        self.service = service
        Task {
            await fetchDetails()
        }
    }
    
    @MainActor
    func fetchDetails() async {
        isLoading = true
        
        do {
            leafDetails = try await service.fetchTreeLeafDetails(id: leaf.id)
        } catch {
            print("error \(error)")
        }
        
        isLoading = false
    }
}
