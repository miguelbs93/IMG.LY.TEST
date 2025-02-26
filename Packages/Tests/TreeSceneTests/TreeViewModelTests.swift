import XCTest
import DTOModels
import Models

@testable import TreeScene

final class TreeViewModelTests: XCTestCase {
    
    var viewModel: TreeViewModel!
    var mockService: MockTreeDataFetcherService!
    
    override func setUp() {
        super.setUp()
        mockService = MockTreeDataFetcherService()
        viewModel = TreeViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchData Success
    
    func testFetchData_Success() async {
        let expectedNodes = [
            TreeNodeDTO(children: nil, id: "1", label: "Node 1"),
            TreeNodeDTO(children: nil, id: "2", label: "Node 2")
        ]
        
        mockService.mockTreeData = expectedNodes
        
        try? await viewModel.fetchData()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.nodes.count, expectedNodes.count)
        XCTAssertEqual(viewModel.nodes.first?.label, "Node 1")
    }
    
    // MARK: - Test fetchData Failure
    
    func testFetchData_Failure() async {
        mockService.shouldThrowError = true
        
        try? await viewModel.fetchData()
        
        XCTAssertFalse(viewModel.isLoading)
        // Since we're not handling any error being thrown, we're just going to check whether we received any data or not
        XCTAssertEqual(viewModel.nodes.count, 0)
    }
    
    // MARK: - Test Delete Item
    
    func testDeleteItem() {
        viewModel.nodes = [
            TreeNode(children: nil, id: "1", label: "Node 1"),
            TreeNode(children: nil, id: "2", label: "Node 2")
        ]
        
        let indexSet = IndexSet(integer: 0)
        
        viewModel.deleteItem(at: indexSet)
        
        XCTAssertEqual(viewModel.nodes.count, 1)
        XCTAssertEqual(viewModel.nodes.first?.id, "2")
    }
    
    // MARK: - Test Move Item
    func testMoveItem() {
        viewModel.nodes = [
            TreeNode(children: nil, id: "1", label: "Node 1"),
            TreeNode(children: nil, id: "2", label: "Node 2"),
            TreeNode(children: nil, id: "3", label: "Node 3")
        ]
        
        let source = IndexSet(integer: 0)
        let destination = 3
        
        viewModel.moveItem(from: source, to: destination)
        
        XCTAssertEqual(viewModel.nodes[2].id, "1")
    }
}
