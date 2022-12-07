import XCTest

final class PostsSceneSuccessfulResponseUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["ui-testing"]
        app.launchEnvironment = ["network-response-fail":"0"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testListHasCorrectNumberOfItems() {
        let list = app.collectionViews["postsList"]
        XCTAssertTrue(list.waitForExistence(timeout: 5))
        
        let listCells = list.cells
        XCTAssertEqual(listCells.count, 2)
        
        XCTAssertTrue(listCells.staticTexts["Post title 1"].exists)
        XCTAssertTrue(listCells.staticTexts["Post title 2"].exists)
        XCTAssertTrue(listCells.staticTexts["User Name"].exists)
    }
}
