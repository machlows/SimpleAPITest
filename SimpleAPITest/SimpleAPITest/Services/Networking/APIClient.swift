import Foundation
import Combine

protocol ApiClientInterface {
    func posts() -> AnyPublisher<[Post], Error>
    func comments(postId: Int) -> AnyPublisher<[Comment], Error>
    func users() -> AnyPublisher<[User], Error>
}

class ApiClient: ApiClientInterface {
    private var urlSession: URLSession
    private let decoder: JSONDecoder
    
    private var cancellables = Set<AnyCancellable>()
    
    init(with session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = session
        self.decoder = decoder
    }
    
    private func requestPublisher<T: Decodable>(request: Request) -> AnyPublisher<T, Error> {
        urlSession
            .dataTaskPublisher(for: request.url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .catch { _ in Empty<T, Error>() }
            .eraseToAnyPublisher()
    }
    
    func posts() -> AnyPublisher<[Post], Error> {
        requestPublisher(request: .posts)
    }
    
    func comments(postId: Int) -> AnyPublisher<[Comment], Error> {
        requestPublisher(request: .comments(postId))
    }
    
    func users() -> AnyPublisher<[User], Error> {
        requestPublisher(request: .users)
    }
}
