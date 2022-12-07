import Foundation
import Combine

struct PostViewItemModel: Equatable {
    let id: Int
    let title: String
    let body: String
    let userName: String
}

class PostsViewModel: ObservableObject, Navigable {
    @Published var items = [PostViewItemModel]()
    private var apiClient: ApiClientInterface
    
    let didSelectPostId = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }
    
    func loadData() {
        apiClient.posts()
            .combineLatest(apiClient.users())
            .receive(on: DispatchQueue.main)
            .map { posts, users in
                let itemModels = posts.map { post in
                    let postUserName = users.first(where: {$0.id == post.userId})?.name ?? "User Not found"
                    return PostViewItemModel(id: post.id,
                                             title: post.title,
                                             body: post.body,
                                             userName: postUserName)
                }
                return itemModels
            }
            .replaceError(with: [PostViewItemModel(id: 0, title: "Network error", body: "", userName: "")])
            .sink(receiveValue: {[weak self] models in
                guard let self = self else { return }
                self.items = models
            })
            .store(in: &cancellables)
    }
    
    func didSelect(index: Int) {
        didSelectPostId.send(items[index].id)
    }
}
