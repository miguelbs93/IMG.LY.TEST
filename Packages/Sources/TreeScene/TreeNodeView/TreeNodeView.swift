import Helpers
import Models
import SwiftUI

struct TreeNodeView: View {
    let node: TreeNode
    @EnvironmentObject var coordinator: TreeCoordinator
    @EnvironmentObject var viewModel: TreeViewModel
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        List {
            if let children = node.children {
                ForEach(children, id: \.id) { child in
                    let destination = child.isLeaf ? TreeCoordinator.Screen.detail(child.id, child.label) : TreeCoordinator.Screen.treeNode(child.id)
                    NavigationLink(value: destination) {
                        Text(child.label)
                    }
                }
                .onDelete(perform: editMode?.wrappedValue == .active ? deleteItem : nil)
                .onMove(perform: editMode?.wrappedValue == .active ? moveItem : nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.detailsFont)
                .background(Color.themeRowBackground)
                .listRowBackground(Color.themeRowBackground)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.themeBackground)
        .navigationTitle(node.label)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        node.children?.remove(atOffsets: offsets)
    }
    
    private func moveItem(from source: IndexSet, to destination: Int) {
        node.children?.move(fromOffsets: source, toOffset: destination)
    }
}
