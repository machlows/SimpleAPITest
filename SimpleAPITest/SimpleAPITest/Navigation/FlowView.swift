import SwiftUI

struct FlowView: View {
    @StateObject var viewModel: FlowViewModel

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack() {
                PostsScene(viewModel: viewModel.makePostsViewModel())
            }
            .navigationDestination(for: Screen.self) {screen in
                switch screen {
                case .commentsScreen(let viewModel):
                    CommentsScene(viewModel: viewModel)
                }
            }
        }
    }
}
