//
//  ContentView.swift
//  IMG.LY.TEST
//
//  Created by Miguel Bou Sleiman on 2/19/25.
//

import SwiftUI

@main
struct TreeViewApp: App {
    @StateObject private var viewModel = TreeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TreeView()
            }
            .environmentObject(viewModel)
        }
    }
}

// MARK: - Model
struct TreeNode: Identifiable, Codable {
    let id: String?
    let label: String
    var children: [TreeNode]?
}

// MARK: - ViewModel
class TreeViewModel: ObservableObject {
    @Published var nodes: [TreeNode] = []
    @Published var theme: Theme = .light
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://ubique.img.ly/frontend-tha/data.json") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        self.nodes = try JSONDecoder().decode([TreeNode].self, from: data)
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                }
            }
        }.resume()
    }
}

// MARK: - View
struct TreeView: View {
    @EnvironmentObject var viewModel: TreeViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.nodes) { node in
                NavigationLink(destination: TreeNodeView(node: node)) {
                    Text(node.label)
                }
            }
        }
        .navigationTitle("Tree Structure")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Theme") {
                    viewModel.theme.toggle()
                }
            }
        }
    }
}

struct TreeNodeView: View {
    let node: TreeNode
    
    var body: some View {
        List {
            if let children = node.children {
                ForEach(children) { child in
                    if let _ = child.children {
                        NavigationLink(destination: TreeNodeView(node: child)) {
                            Text(child.label)
                        }
                    } else {
                        NavigationLink(destination: DetailView(id: child.id)) {
                            Text(child.label)
                        }
                    }
                }
            }
        }
        .navigationTitle(node.label)
    }
}

struct DetailView: View {
    let id: String?
    @State private var details: String = "Loading..."
    
    var body: some View {
        Text(details)
            .padding()
            .onAppear {
                fetchDetails()
            }
    }
    
    func fetchDetails() {
        guard let id = id, let url = URL(string: "https://ubique.img.ly/frontend-tha/entries/\(id).json") else {
            details = "No Details Available"
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let text = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    details = text
                }
            }
        }.resume()
    }
}

// MARK: - Theming
enum Theme {
    case light, dark
    
    mutating func toggle() {
        self = (self == .light) ? .dark : .light
    }
}
