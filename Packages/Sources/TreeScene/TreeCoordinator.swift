import SwiftUI
import NetworkManager
import Services
import Models

class TreeCoordinator: ObservableObject {
    @Published var path: [Screen] = []
    private let networkManager: NetworkService

    enum Screen: Hashable {
        case treeView
        case treeNode(TreeNode)
        case detail(TreeNode)
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
        case .treeNode(let node):
            makeTreeNodeView(with: node)
        case .detail(let node):
            makeDetailView(with: node)
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
        let viewModel = TreeViewModel(networkManager: networkManager)
        return TreeView()
            .environmentObject(viewModel)
    }
    
    private func makeTreeNodeView(with node: TreeNode) -> some View {
        TreeNodeView(node: node)
    }
    
    private func makeDetailView(with leaf: TreeNode) -> some View {
        let service = TreeDataFetcherService(networkManager: networkManager)
        let viewModel = DetailViewModel(leaf: leaf, service: service)
        return DetailView(viewModel: viewModel)
    }
}

// MARK: - TreeCoordinatorView

struct TreeCoordinatorView: View {
    @StateObject private var coordinator = TreeCoordinator(networkManager: DefaultNetworkManager())

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.makeInitialTreeView()
                .navigationDestination(for: TreeCoordinator.Screen.self) { screen in
                    coordinator.destination(for: screen)
                }
        }
        .environmentObject(coordinator)
    }
}
