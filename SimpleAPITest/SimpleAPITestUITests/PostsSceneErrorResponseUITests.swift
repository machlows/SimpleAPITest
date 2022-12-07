import XCTest

final class PostsSceneErrorResponseUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launchArguments = ["ui-testing"]
        app.launchEnvironment = ["network-response-fail":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testListHasCorrectNumberOfItems() {
        let list = app.collectionViews["postsList"]
        XCTAssertTrue(list.waitForExistence(timeout: 5))
        
        let listCells = list.cells
        XCTAssertEqual(listCells.count, 1)
        
        XCTAssertTrue(listCells.staticTexts["Network error"].exists)
    }
}

