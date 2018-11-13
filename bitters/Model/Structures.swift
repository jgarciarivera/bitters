//
//  Structures.swift
//  bitters
//
//  Created by Luis Flores on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Default Texts as a reference for defaultValues of Cocktail Struct

let defaultLongText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in, semper lacinia nisl. Mauris erat ex, dictum vitae purus ac, interdum ornare lacus. Nulla tempor dictum est."
let defaultMediumText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in."
let dafaultShortText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
let defaultInstructions = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                           "Vestibulum consequat lacus sit amet tempus mollis.",
                           "Nulla tempor dictum est, et viverra nisi."]

let mockIngredientOne = Ingredient(name: "vodka", category: Ingredient.category.Vodka)
let mockIngredientTwo = Ingredient(name: "lime juice", category: Ingredient.category.Juice)
let mockIngredientThree = Ingredient(name: "ginger beer", category: Ingredient.category.Other)
let defaultIngredients = [mockIngredientOne, mockIngredientTwo, mockIngredientThree]

let dbDelegate: dbConnectionDelegate = DatabaseConnection()

//MARK: - Cocktail Struct

struct Cocktail {
    let name: String
    let about: String
    let description: String
    let instructions: [String]
    let ingredients: [Ingredient]
    let image: UIImage
    
    init(name: String,
         about: String = defaultLongText,
         description: String = defaultMediumText,
         instructions: [String] = [dafaultShortText],
         ingredients:[Ingredient] = dbDelegate.getUserIngredients(),
         image: UIImage = UIImage(named: "cellDefault")!) {
        self.name = name
        self.about = about
        self.image = image
        self.description = description
        self.instructions = instructions
        self.ingredients = ingredients
    }
    
    init() {
        self.name = ""
        self.about = ""
        self.image = UIImage(named: "defaultCocktailPhoto")!
        self.description = ""
        self.instructions = []
        self.ingredients = []
    }
}


// MARK: - Ingredient Struct

struct Ingredient {
    
    enum category: String, CaseIterable {
        case Rum
        case Vodka
        case Tequila
        case Gin
        case Whiskey
        case Brandy
        case Cognac
        case Absinthein
        case Mezcal
        case Soju
        case Bourbon
        case Rye = "Rye whiskey"
        case Scotch = "Scotch Whiskey"
        case TennWhiskey = "Tennessee Whiskey"
        case Juice
        case Other
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
