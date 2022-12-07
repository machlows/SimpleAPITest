import Foundation
import Combine

struct CommentViewItemModel: Identifiable {
    var id = UUID()
    let name: String
    let email: String
    let body: String
}

class CommentsViewModel: ObservableObject, Navigable {
    @Published var comments = [CommentViewItemModel]()
    private let postId: Int
    private var apiClient: ApiClientInterface
    
    private var cancellables = Set<AnyCancellable>()
    
    init(postId: Int, apiClient: ApiClientInterface) {
        self.apiClient = apiClient
        self.postId = postId
    }
    
    func loadData() {
        apiClient.comments(postId: postId)
            .receive(on: DispatchQueue.main)
            .map({ comments in
                comments.map{ CommentViewItemModel(name: $0.name,
                                                   email: $0.email,
                                                   body: $0.body)}
            })
            .replaceError(with: [CommentViewItemModel(name: "Error", email: "", body: "Network error")])
            .sink(receiveValue: {[weak self] comments in
                guard let self = self else { return }
                self.comments = comments
            })
            .store(in: &cancellables)
    }
}
