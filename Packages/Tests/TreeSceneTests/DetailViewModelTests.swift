import XCTest
import DTOModels
import Models
import TreeScene
import NetworkManager

final class DetailViewModelTests: XCTestCase {
    
    func testFetchDetails_Success() async {
        let mockService = MockTreeDataFetcherService()
        let expectedDetail = TreeLeafDetailDTO.init(
            createdAt: Date(),
            createdBy: "Miguel",
            description: "Lorum ipsum",
            id: "1",
            lastModifiedAt: Date(),
            lastModifiedBy: "Miguel"
        )
        
        mockService.mockLeafDetail = expectedDetail
        
        let viewModel = DetailViewModel(leafID: "123", title: "Leaf", service: mockService)
        
        await viewModel.fetchDetails()
        
        XCTAssertEqual(viewModel.leafDetails?.id, expectedDetail.id)
        XCTAssertEqual(viewModel.leafDetails?.description, expectedDetail.description)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.showAlert)
    }
    
    func testFetchDetails_404Error() async {
        let mockService = MockTreeDataFetcherService()
        mockService.error = NetworkError.invalidResponse(code: 404)

        let viewModel = DetailViewModel(leafID: "123", title: "Leaf", service: mockService)
        
        await viewModel.fetchDetails()
        
        XCTAssertNil(viewModel.leafDetails)
        XCTAssertEqual(viewModel.errorMessage, "No data found for this leaf!")
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchDetails_GenericError() async {
        let mockService = MockTreeDataFetcherService()
        mockService.error = NetworkError.decodingError

        let viewModel = DetailViewModel(leafID: "123", title: "Leaf", service: mockService)
        
        await viewModel.fetchDetails()
        
        XCTAssertNil(viewModel.leafDetails)
        XCTAssertEqual(viewModel.errorMessage, "Something went wrong, please try again later!")
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertFalse(viewModel.isLoading)
    }
}
