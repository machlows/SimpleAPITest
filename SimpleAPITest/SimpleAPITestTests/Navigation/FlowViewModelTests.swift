import XCTest
@testable import SimpleAPITest

class FlowViewModelTests: XCTestCase {
    
    func testNavigatesWhenSelectedPost() throws {
        let sut = FlowViewModel()
        XCTAssertEqual(sut.navigationPath.count, 0)
        
        let postsViewModel = sut.makePostsViewModel()
        postsViewModel.items = [PostViewItemModel(id: 0, title: "", body: "", userName: "")]
        postsViewModel.didSelect(index: 0)
        XCTAssertEqual(sut.navigationPath.count, 1)
        
        if case Screen.commentsScreen(_) = sut.navigationPath.last! {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
}
