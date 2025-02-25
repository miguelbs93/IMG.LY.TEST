import Helpers
import Models
import SwiftUI

struct TreeNodeView: View {
    let node: TreeNode
    @EnvironmentObject var coordinator: TreeCoordinator
    
    var body: some View {
        List {
            if let children = node.children {
                ForEach(children) { child in
                    let destination = child.isLeaf ? TreeCoordinator.Screen.detail(child) : TreeCoordinator.Screen.treeNode(child)
                    NavigationLink(value: destination) {
                        Text(child.label)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.detailsFont)
                .background(Color.themeRowBackground)
                .listRowBackground(Color.themeRowBackground)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.themeBackground)
        .navigationTitle(node.label)
    }
}
