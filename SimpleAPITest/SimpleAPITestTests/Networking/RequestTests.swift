import XCTest
@testable import SimpleAPITest

class RequestTests: XCTestCase {
    func testPostsRequest() throws {
        let sut = Request.posts
        let expectedURL = URL(string: "https://jsonplaceholder.typicode.com/posts")
        XCTAssertEqual(sut.url, expectedURL)
    }
    
    func testPostRequest() throws {
        let sut = Request.post(1)
        let expectedURL = URL(string: "https://jsonplaceholder.typicode.com/posts/1")
        XCTAssertEqual(sut.url, expectedURL)
    }
    
    func testCommentsRequest() throws {
        let sut = Request.comments(1)
        let expectedURL = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments")
        XCTAssertEqual(sut.url, expectedURL)
    }
    
    func testUsersRequest() throws {
        let sut = Request.users
        let expectedURL = URL(string: "https://jsonplaceholder.typicode.com/users")
        XCTAssertEqual(sut.url, expectedURL)
    }
    
    func testUserRequest() throws {
        let sut = Request.user(1)
        let expectedURL = URL(string: "https://jsonplaceholder.typicode.com/user/1")
        XCTAssertEqual(sut.url, expectedURL)
    }
}
