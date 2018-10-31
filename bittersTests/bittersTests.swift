//
//  bittersTests.swift
//  bittersTests
//
//  Created by Kaelaholme on 10/30/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import XCTest

class bittersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    struct Ingredient {
        
        enum category: String {
            case Rum
            case Vodka
            case Tequila
            case Gin
            case Whiskey
            case Brandy
            case Cognac
        }
        
        let name: String
        let category: category
        let image: UIImage
        
        init(name: String, category: category, image: UIImage = UIImage(named: "cellDefault")!) {
            self.name = name
            self.category = category
            self.image = image
        }
    }
    func testIngredientStruct(){
        let blankImage = UIImage()
        let ingredient = Ingredient(name: "Test", category: Ingredient.category.Rum, image: blankImage)
        XCTAssertEqual(ingredient.category, Ingredient.category.Rum)
    }
}
