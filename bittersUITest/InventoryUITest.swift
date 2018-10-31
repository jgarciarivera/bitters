//
//  InventoryUITest.swift
//  bittersUITest
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import XCTest

class InventoryUITest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
//    func testCanUseSearchBar() {
//
//        let searchBar = app.searchFields["InventorySearchBar"]
//        searchBar.clearAnd
//        assert(true)
//
//    }

}
