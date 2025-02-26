import SwiftUI
import Helpers

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    private enum constants: CGFloat {
        case horizontalPadding = 16
        case verticalPadding = 8
    }
    
    var body: some View {
        ZStack {
            Color.themeBackground
                        .edgesIgnoringSafeArea(.all)
            
            if viewModel.leafDetails != nil {
                ScrollView {
                    detailText
                    header
                }
                .background(Color.themeBackground)
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .navigationTitle(viewModel.title)
        .alert(
            "Error",
            isPresented: $viewModel.showAlert,
            actions: {
                Button("OK", role: .cancel) {
                    dismiss()
                }
            },
            message: {
                Text(viewModel.errorMessage ?? "Something went wrong, try again later!")
            }
        )
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Created at: \(viewModel.leafDetails?.createdAt.toString() ?? "")")
            Text("Created by: \(viewModel.leafDetails?.createdBy ?? "")")
            Text("Last modified at: \(viewModel.leafDetails?.lastModifiedAt.toString() ?? "")")
            Text("Last modified by: \(viewModel.leafDetails?.lastModifiedBy ?? "")")
        }
        .font(.tinyDetailsFont)
        .foregroundColor(Color.themeText)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, constants.horizontalPadding.rawValue)
        .padding(.vertical, constants.verticalPadding.rawValue)
    }
    
    private var detailText: some View {
        Text(viewModel.leafDetails?.description ?? "")
            .font(.detailsFont)
            .foregroundColor(Color.themeText)
            .padding(.horizontal, constants.horizontalPadding.rawValue)
    }
}
