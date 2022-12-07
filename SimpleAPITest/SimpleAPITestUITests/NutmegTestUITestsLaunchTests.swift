
let app = XCUIApplication()
app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["sunt aut facere repellat provident occaecati excepturi optio reprehenderit"]/*[[".cells.staticTexts[\"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\"]",".staticTexts[\"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

let commentsNavigationBar = app.navigationBars["Comments"]
commentsNavigationBar.staticTexts["Comments"].tap()
commentsNavigationBar.buttons["Today's posts"].tap()

//
//  NutmegTestUITestsLaunchTests.swift
//  NutmegTestUITests
//
//  Created by Tomasz Machlowski on 01/12/2022.
//

import XCTest

final class NutmegTestUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
