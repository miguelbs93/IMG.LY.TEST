import SwiftUI
import Helpers

struct TreeView: View {
    @EnvironmentObject var viewModel: TreeViewModel
    @EnvironmentObject var coordinator: TreeCoordinator
        
    var body: some View {
        if viewModel.nodes.isEmpty {
            VStack {
                Text("No data available.")
                Button("Retry") {
                    
                }
            }
            .navigationTitle("Tree View")
        } else {
            List {
                ForEach(viewModel.nodes) { node in
                    NavigationLink(value: TreeCoordinator.Screen.treeNode(node)) {
                        Text(node.label)
                            .font(.detailsFont)
                    }
                }
            }
            .navigationTitle("Tree View")
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        TreeView()
    }
}
