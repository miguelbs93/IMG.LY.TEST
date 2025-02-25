import SwiftUI
import Helpers

struct TreeView: View {
    @EnvironmentObject var viewModel: TreeViewModel
    @EnvironmentObject var coordinator: TreeCoordinator
    @EnvironmentObject var themeManager: ThemeManager
        
    var body: some View {
        Group {
            if viewModel.nodes.isEmpty {
                VStack {
                    Text("No data available.")
                    Button("Retry") {
                        
                    }
                }
            } else {
                List {
                    ForEach(viewModel.nodes) { node in
                        NavigationLink(value: TreeCoordinator.Screen.treeNode(node)) {
                            Text(node.label)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.detailsFont)
                                .background(Color.themeRowBackground)
                        }
                        .listRowBackground(Color.themeRowBackground)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.themeBackground)
        .navigationTitle("Tree View")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(themeManager.isDarkMode ? "🌞" : "🌙") {
                    themeManager.toggleTheme()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                }
            }
        }
        .id(themeManager.isDarkMode)
    }
}
