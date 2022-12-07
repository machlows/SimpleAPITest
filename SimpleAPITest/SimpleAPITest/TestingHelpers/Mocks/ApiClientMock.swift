#if DEBUG
import Foundation
import Combine

enum TestError: Error {
    case testNetworkError
}

class ApiClientMock: ApiClientInterface {
    var postsToReturn = [Post]()
    var errorToReturn: Error?
    func posts() -> AnyPublisher<[Post], Error> {
        if let errorToReturn {
            return Fail(outputType: [Post].self, failure: errorToReturn)
                .eraseToAnyPublisher()
        } else {
            return Just(postsToReturn)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    var usersToReturn = [User]()
    func users() -> AnyPublisher<[User], Error> {
        Just(usersToReturn)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    var commentsToReturn = [Comment]()
    func comments(postId: Int) -> AnyPublisher<[Comment], Error> {
        Just(commentsToReturn)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

extension ApiClientMock {
    static func errorMock() -> ApiClientMock {
        let mock = ApiClientMock()
        mock.errorToReturn = TestError.testNetworkError
        return mock
    }
    
    static func successMock() -> ApiClientMock {
        let mock = ApiClientMock()
        mock.usersToReturn = [User(id: 0, name: "User Name")]
        mock.postsToReturn = [Post(id: 0, userId: 0, title: "Post title 1", body: "Post body 1"),
                              Post(id: 2, userId: 0, title: "Post title 2", body: "Post body 2")]
        return mock
    }
}
#endif
