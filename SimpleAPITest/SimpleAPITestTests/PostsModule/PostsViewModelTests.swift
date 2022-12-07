import XCTest
import Combine
@testable import SimpleAPITest

class CharactersViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testSuccessfulLoadData() {
        let apiClientMock = ApiClientMock.successMock()
        let sut = PostsViewModel(apiClient: apiClientMock)
        
        sut.loadData()
        
        let expectedData = [PostViewItemModel(id: 0,
                                              title: "Post title 1",
                                              body: "Post body 1",
                                              userName: "User Name"),
                            PostViewItemModel(id: 2,
                                              title: "Post title 2",
                                              body: "Post body 2",
                                              userName: "User Name")]
        
        sut.$items
            .dropFirst()
            .sink { models in
                XCTAssertEqual(models, expectedData)
            }
            .store(in: &cancellables)
    }
    
    func testMissingUserLoadData() {
        let apiClientMock = ApiClientMock()
        let sut = PostsViewModel(apiClient: apiClientMock)
        
        let testPosts = [Post(id: 0, userId: 0, title: "title", body: "body")]
        apiClientMock.postsToReturn = testPosts
        
        sut.loadData()
        
        let expectedData = [PostViewItemModel(id: testPosts.first!.id,
                                              title: testPosts.first!.title,
                                              body: testPosts.first!.body,
                                              userName: "User Not found")]
        
        sut.$items
            .dropFirst()
            .sink { models in
                XCTAssertEqual(models, expectedData)
            }
            .store(in: &cancellables)
    }
    
    func testLoadDataFailedWithError() {
        let apiClientMock = ApiClientMock.errorMock()
        let sut = PostsViewModel(apiClient: apiClientMock)
        
        sut.loadData()
        
        let expectedData = [PostViewItemModel(id: 0,
                                              title: "Network error",
                                              body: "",
                                              userName: "")]
        
        sut.$items
            .dropFirst()
            .sink { models in
                XCTAssertEqual(models, expectedData)
            }
            .store(in: &cancellables)
    }
    
    func testDidSelectPost() {
        let apiClientMock = ApiClientMock()
        let sut = PostsViewModel(apiClient: apiClientMock)
        
        let testPosts = [Post(id: 10, userId: 0, title: "title", body: "body")]
        sut.items = [PostViewItemModel(id: testPosts.first!.id,
                                       title: testPosts.first!.title,
                                       body: testPosts.first!.body,
                                       userName: "userName")]
        
        sut.didSelect(index: 0)
        sut.didSelectPostId.sink { postId in
            XCTAssertEqual(postId, testPosts.first!.id)
        }
        .store(in: &cancellables)
    }
    
}
