import SwiftUI
import NetworkManager
import Services
import Models

class TreeCoordinator: ObservableObject {
    @Published var path: [Screen] = []
    private let networkManager: NetworkService
    private var treeViewModel: TreeViewModel!

    enum Screen: Hashable {
        case treeView
        case treeNode(String)
        case detail(String, String)
    }
    
    init(path: [Screen] = [], networkManager: NetworkService) {
        self.path = path
        self.networkManager = networkManager
    }

    @ViewBuilder
    func destination(for screen: Screen) -> some View {
        switch screen {
        case .treeView:
            makeInitialTreeView()
        case .treeNode(let nodeID):
            makeTreeNodeView(with: nodeID)
        case .detail(let nodeID, let title):
            makeDetailView(with: nodeID, title: title)
        }
    }

    func navigateTo(_ screen: Screen) {
        path.append(screen)
    }

    func goBack() {
        path.removeLast()
    }

    func goToRoot() {
        path.removeAll()
    }
}

// MARK: - Views

extension TreeCoordinator {
    func makeInitialTreeView() -> some View {
        if treeViewModel == nil {
            treeViewModel = TreeViewModel(networkManager: networkManager)
        }
        return TreeView()
            .environmentObject(treeViewModel)
    }
    
    private func makeTreeNodeView(with nodeID: String) -> some View {
        guard let selectedNode = getNode(nodeID, in: treeViewModel.nodes) else { return AnyView(EmptyView()) }
        return AnyView(
            TreeNodeView(node: selectedNode)
                .environmentObject(treeViewModel)
        )
    }
    
    private func makeDetailView(with nodeID: String, title: String) -> some View {
        let service = TreeDataFetcherService(networkManager: networkManager)
        let viewModel = DetailViewModel(leafID: nodeID, title: title, service: service)
        return DetailView(viewModel: viewModel)
    }
    
    private func getNode(_ id: String, in nodes: [TreeNode]) -> TreeNode? {
        for node in nodes {
            if node.id == id {
                return node
            }
            
            if let children = node.children,
                let found = getNode(id, in: children) {
                return found
            }
        }
        return nil
    }

}

// MARK: - TreeCoordinatorView

public struct TreeCoordinatorView: View {
    @StateObject private var coordinator = TreeCoordinator(networkManager: DefaultNetworkManager())

    public init() { }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.makeInitialTreeView()
                .navigationDestination(for: TreeCoordinator.Screen.self) { screen in
                    coordinator.destination(for: screen)
                }
        }
        .applyTheme()
        .environmentObject(coordinator)
    }
}
