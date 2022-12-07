import Foundation
import Combine
import SwiftUI

protocol Navigable: AnyObject, Identifiable, Hashable {}

extension Navigable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Screen: Hashable {
    case commentsScreen(viewModel: CommentsViewModel)
}

class FlowViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private var apiClient: ApiClientInterface = ApiClient()
    
    @Published var navigationPath: [Screen] = []
    
    func makePostsViewModel() -> PostsViewModel {
        let viewModel: PostsViewModel
#if DEBUG
        if UITestingHelper.isUITesting {
            if UITestingHelper.shouldPostsResponseFail {
                viewModel = PostsViewModel(apiClient: ApiClientMock.errorMock())
            } else {
                viewModel = PostsViewModel(apiClient: ApiClientMock.successMock())
            }
        } else {
            viewModel = PostsViewModel(apiClient: apiClient)
        }
#else
        viewModel = PostsViewModel(apiClient: apiClient)
#endif
        
        viewModel.didSelectPostId
            .sink(receiveValue: didSelectPostId)
            .store(in: &subscription)
        
        return viewModel
    }
    
    func makeCommentsViewModel(for postId: Int) -> CommentsViewModel {
        let viewModel = CommentsViewModel(postId: postId,
                                          apiClient: apiClient)
        return viewModel
    }
    
    func didSelectPostId(postId: Int) {
        navigationPath.append(.commentsScreen(viewModel: makeCommentsViewModel(for: postId)))
    }
}
