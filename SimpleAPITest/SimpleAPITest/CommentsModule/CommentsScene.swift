import SwiftUI

struct CommentsScene: View {
    @StateObject var viewModel: CommentsViewModel
    
    var body: some View {
        NavigationView {
            commentsView
        }
        .navigationBarTitle("Comments", displayMode: .large)
        .onAppear(perform: viewModel.loadData)
    }
    
    private var commentsView: some View {
        List {
            ForEach(viewModel.comments) { model in
                commentCardView(model)
                    .padding(.horizontal, 4)
            }
        }
    }
    
    private func commentCardView(_ model: CommentViewItemModel) -> some View {
        VStack(alignment: .leading) {
            HStack() {
                Text(model.name)
                    .font(.headline)
                Spacer()
                Text(model.email)
                    .font(.subheadline)
            }
            .padding(.bottom, 16)
            
            Text(model.body)
                .font(.body)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 118)
        .background(Color.secondary)
        .cornerRadius(10)
    }
}
