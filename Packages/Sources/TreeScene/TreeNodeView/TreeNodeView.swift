import Models
import SwiftUI

struct TreeNodeView: View {
    let node: TreeNode
    @EnvironmentObject var coordinator: TreeCoordinator
    
    var body: some View {
        List {
            if let children = node.children {
                ForEach(children) { child in
                    if child.isLeaf {
                        NavigationLink(value: TreeCoordinator.Screen.detail(child)) {
                            Text(child.label)
                                .font(.detailsFont)
                        }
                    } else {
                        NavigationLink(value: TreeCoordinator.Screen.treeNode(child)) {
                            Text(child.label)
                                .font(.detailsFont)
                        }
                    }
                }
            }
        }
        .navigationTitle(node.label)
    }
}
