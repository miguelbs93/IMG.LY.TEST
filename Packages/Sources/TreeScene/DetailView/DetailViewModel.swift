import Foundation
import Services
import DTOModels
import Models
import NetworkManager

final class DetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var leafDetails: TreeLeafDetailDTO?
    @Published var showAlert: Bool = false
    
    var errorMessage: String?
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
            if let networkError = error as? NetworkError,
               case .invalidResponse(let code) = networkError, code == 404 {
                self.errorMessage = "No data found for this leaf!"
            } else {
                self.errorMessage = "Something went wrong, please try again later!"
            }
            self.showAlert = true
        }
        
        isLoading = false
    }
}
