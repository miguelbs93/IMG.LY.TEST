import SwiftUI
import Helpers

struct TreeView: View {
    @EnvironmentObject var viewModel: TreeViewModel
    @EnvironmentObject var coordinator: TreeCoordinator
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.editMode) private var editMode
        
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
                    ForEach(viewModel.nodes, id: \.id) { node in
                        NavigationLink(value: TreeCoordinator.Screen.treeNode(node.id)) {
                            Text(node.label)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.detailsFont)
                                .background(Color.themeRowBackground)
                        }
                        .listRowBackground(Color.themeRowBackground)
                    }
                    .onDelete(perform: editMode?.wrappedValue == .active ? deleteItem : nil)
                    .onMove(perform: editMode?.wrappedValue == .active ? moveItem : nil)
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
                EditButton()
            }
        }
        .id(themeManager.isDarkMode)
    }
    
    private func deleteItem(at offsets: IndexSet) {
//        viewModel.deleteItem(at: offsets)
    }
    
    private func moveItem(from source: IndexSet, to destination: Int) {
//        viewModel.moveItem(from: source, to: destination)
    }
}
