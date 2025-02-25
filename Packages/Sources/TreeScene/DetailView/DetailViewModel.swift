import Foundation
import Services
import DTOModels
import Models

final class DetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var leafDetails: TreeLeafDetailDTO?
    
    private let leafID: String
    var title: String
    private let service: TreeDataFetcherServiceProtocol
    
    init(
        leafID: String,
        title: String,
        service: TreeDataFetcherServiceProtocol
    ) {
        self.leafID = leafID
        self.title = title
        self.service = service
        Task {
            await fetchDetails()
        }
    }
    
    @MainActor
    func fetchDetails() async {
        isLoading = true
        
        do {
            leafDetails = try await service.fetchTreeLeafDetails(id: leafID)
        } catch {
            print("error \(error)")
        }
        
        isLoading = false
    }
}
