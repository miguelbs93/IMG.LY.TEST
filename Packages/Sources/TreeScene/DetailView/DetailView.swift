import SwiftUI
import Helpers

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    private enum constants: CGFloat {
        case horizontalPadding = 16
        case verticalPadding = 8
    }
    
    var body: some View {
        if viewModel.isLoading {
            VStack {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            .navigationTitle(viewModel.title)
        } else {
            ScrollView {
                if viewModel.leafDetails != nil {
                    detailText
                    header
                }
            }
            .navigationTitle(viewModel.title)
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Created at: \(viewModel.leafDetails?.createdAt.toString() ?? "")")
            Text("Created by: \(viewModel.leafDetails?.createdBy ?? "")")
            Text("Last modified at: \(viewModel.leafDetails?.lastModifiedAt.toString() ?? "")")
            Text("Last modified by: \(viewModel.leafDetails?.lastModifiedBy ?? "")")
        }
        .font(.tinyDetailsFont)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, constants.horizontalPadding.rawValue)
        .padding(.vertical, constants.verticalPadding.rawValue)
    }
    
    private var detailText: some View {
        Text(viewModel.leafDetails?.description ?? "")
            .font(.detailsFont)
            .padding(.horizontal, constants.horizontalPadding.rawValue)
    }
}
