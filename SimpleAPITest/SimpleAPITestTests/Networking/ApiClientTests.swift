import XCTest
@testable import SimpleAPITest

class APIClientTests: XCTestCase {
    
    func testSuccessfullyPerformingPostsRequest() throws {
        let session = URLSession(mockResponder: Post.MockDataURLResponder.self)
        let sut = ApiClient(with: session)
        
        let publisher = sut.posts()
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result, [Post.MockDataURLResponder.posts])
    }
    
    func testSuccessfullyPerformingCommentsRequest() throws {
        let session = URLSession(mockResponder: Comment.MockDataURLResponder.self)
        let sut = ApiClient(with: session)
        
        let publisher = sut.comments(postId: 0)
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result, [Comment.MockDataURLResponder.comments])
    }
    
    func testSuccessfullyPerformingUsersRequest() throws {
        let session = URLSession(mockResponder: User.MockDataURLResponder.self)
        let sut = ApiClient(with: session)
        
        let publisher = sut.users()
        let result = try awaitCompletion(of: publisher)
        
        XCTAssertEqual(result, [User.MockDataURLResponder.users])
    }
}
