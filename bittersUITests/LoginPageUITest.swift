//
//  LoginPageUITest.swift
//  bittersUITests
//
//  Created by Kristian Galvan on 10/25/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import XCTest

class LoginPageUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }



    func testCanEnterUsername() {
        let app = XCUIApplication()
        
        let usernameTextField = app.otherElements.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("user")
        XCTAssertEqual(usernameTextField.value as? String, "user")
        
    }
    func testCanEnterPassword() {
        let app = XCUIApplication()
        
        let usernameTextField = app.otherElements.textFields["passwordTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("password")
        XCTAssertEqual(usernameTextField.value as? String, "password")
        
    }
}
