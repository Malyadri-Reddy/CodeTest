//
//  CodeTestUITests.swift
//  CodeTestUITests
//
//  Created by Malyadri on 18/08/25.
//

import XCTest

final class CodeTestUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testLoginSuccessNavigatesToList() {
           let usernameField = app.textFields["Username"]
           let passwordField = app.secureTextFields["Password"]
           let loginButton   = app.buttons["Login"]

           XCTAssertTrue(usernameField.exists)
           XCTAssertTrue(passwordField.exists)
           XCTAssertTrue(loginButton.exists)

           usernameField.tap()
           usernameField.typeText("admin")

           passwordField.tap()
           passwordField.typeText("1234")

           loginButton.tap()

           // Verify navigation to PostListView
           let postList = app.navigationBars["Posts"]
           XCTAssertTrue(postList.waitForExistence(timeout: 3))
       }
    
    func testLoginFailureShowsErrorMessage() {
            let usernameField = app.textFields["Username"]
            let passwordField = app.secureTextFields["Password"]
            let loginButton   = app.buttons["Login"]

            usernameField.tap()
            usernameField.typeText("wrong")

            passwordField.tap()
            passwordField.typeText("user")

            loginButton.tap()

            // Verify error text
            let errorLabel = app.staticTexts["Invalid credentials"]
            XCTAssertTrue(errorLabel.waitForExistence(timeout: 2))
        }
    
    func testPostListDisplaysItems() {
           loginAsAdmin() // helper method for reusability

           let firstCell = app.tables.cells.element(boundBy: 0)
           XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
       }
    
    func testNavigateToPostDetail() {
           loginAsAdmin()

           let firstCell = app.tables.cells.element(boundBy: 0)
           XCTAssertTrue(firstCell.exists)

           firstCell.tap()

           // Verify detail screen has a title or body
           let detailText = app.staticTexts.element(boundBy: 0)
           XCTAssertTrue(detailText.waitForExistence(timeout: 3))
       }
    
    private func loginAsAdmin() {
            let usernameField = app.textFields["Username"]
            let passwordField = app.secureTextFields["Password"]
            let loginButton   = app.buttons["Login"]

            usernameField.tap()
            usernameField.typeText("admin")

            passwordField.tap()
            passwordField.typeText("1234")

            loginButton.tap()
        }


}
