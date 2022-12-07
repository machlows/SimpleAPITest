import SwiftUI

struct PostsScene: View {
    @StateObject var viewModel: PostsViewModel
    
    var body: some View {
        NavigationView {
            postsView
        }
        .navigationBarTitle("Today's posts", displayMode: .large)
        .onAppear(perform: viewModel.loadData)
    }
    
    private var postsView: some View {
        List {
            ForEach(Array(viewModel.items.enumerated()), id: \.offset) { index, model in
                postCardView(model)
                    .padding(.horizontal, 4)
                    .onTapGesture { viewModel.didSelect(index: index) }
            }
        }
        .accessibilityIdentifier("postsList")
    }
    
    private func postCardView(_ model: PostViewItemModel) -> some View {
        HStack() {
            Text(model.title)
                .font(.headline)
            Spacer()
            Text(model.userName)
                .font(.subheadline)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, minHeight: 118)
        .background(Color.secondary)
        .cornerRadius(10)
    }
}
