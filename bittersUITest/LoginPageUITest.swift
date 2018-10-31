//
//  LoginPageUITest.swift
//  bittersUITest
//
//  Created by Kristian Galvan on 10/26/18.
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

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
        
        let passwordTextField = app.otherElements.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("password")
        XCTAssertEqual(passwordTextField.value as? String, "password")
        
    }
//    func testCanSignIn() {
//        let app = XCUIApplication()
//
//        let usernameTextField = app.otherElements.textFields["usernameTextField"]
//        let passwordTextField = app.otherElements.textFields["passwordTextField"]
//        usernameTextField.tap()
//        usernameTextField.typeText("kristian.galvan@gmail.com")
//        passwordTextField.tap()
//        passwordTextField.typeText("bitters")
//        let submitButton = app.otherElements.buttons["logInButton"]
//        submitButton.tap()
//
////        usernameTextField.
//    }
    
}
