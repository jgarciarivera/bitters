//  Structures.swift
//  bitters
//
//  Created by Luis Flores on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.


import Foundation
import UIKit

// MARK: - Default Texts as a reference for defaultValues of Cocktail Struct

let defaultLongText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in, semper lacinia nisl. Mauris erat ex, dictum vitae purus ac, interdum ornare lacus. Nulla tempor dictum est."
let defaultMediumText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in."
let dafaultShortText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
let defaultInstructions = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                           "Vestibulum consequat lacus sit amet tempus mollis.",
                           "Nulla tempor dictum est, et viverra nisi."]

let defaultCocktailDictionary: [String: Any] = [
    "name": "Gin Fizz",
    "about": "",
    "description": "This is Gin Fizz",
    "instructions": ["Add the first four ingredients to a shaker and dry-shake (without ice) for about 10 seconds.", "Add 3 or 4 ice cubes and shake very well.", "\"Double-strain into a chilled fizz glass and top with club soda.  \""],
    "ingredients": [],
    "image": "https://253qv1sx4ey389p9wtpp9sj0-wpengine.netdna-ssl.com/wp-content/uploads/2018/08/GinFizz-CocktailBeers__Meg-Baggott_Styling_Dylan_Garret.jpg"
]

let sampleIngredientDictionary: [String: Any] = [
    "name": "The Good Shit",
    "category": "cherry liqueur",
    "image": "https://gangslangs.com/wp-content/uploads/2017/09/alcohol-benefits.jpg",
    "id": "shit"
]

// MARK: Delegates

let dbDelegate: dbConnectionDelegate = dbConnection!


let sampleIngredient = Ingredient(dictionary: sampleIngredientDictionary)!

let defaultIngredients = [sampleIngredient, sampleIngredient, sampleIngredient]

// MARK: - Cocktail Struct

struct Cocktail {
    let name: String
    let about: String
    let description: String
    let instructions: [String]
    let ingredients: [Ingredient]
    let image: URL
}

extension Cocktail: DocumentSerializable {
    init?(dictionary: [String : Any]) {

        guard let name = dictionary["name"] as? String ,
            let about = dictionary["about"] as? String,
            let description = dictionary["description"] as? String,
            let instructions = dictionary["instructions"] as? [String],
            let ingredients = dictionary["ingredients"] as? [Ingredient],
            let image = (dictionary["image"] as? String).flatMap(URL.init(string:))
            else { return nil }

        self.init(name: name, about: about, description: description , instructions: instructions, ingredients: ingredients, image: image)
    }
    
    //MARK: Regactor Getting Ingredient Map
    
    init?(dbDictionary: [String : Any]) {
        
        guard let name = dbDictionary["name"] as? String ,
            let about = dbDictionary["about"] as? String,
            let description = dbDictionary["description"] as? String,
            let instructions = dbDictionary["instructions"] as? [String],
            let ingredients = dbDictionary["ingredients"] as? [[String : Any]],
            let image = (dbDictionary["image"] as? String).flatMap(URL.init(string:))
            else {
                print("Unable to initialize type \(Cocktail.self) with dictionary FUCK \((dbDictionary["ingredients"]! as! [String])[0])")
                fatalError("Unable to initialize type \(Cocktail.self) with dictionary FUCK \((dbDictionary["ingredients"]! as! [String])[0])")
            }
        
        let ingredientPointers = ingredients.map { (ingredientMap) -> String in
            if let ptr = ingredientMap["id"]! as? String {
                return ptr
            } else {
                fatalError("hmm")
            }
        }
        
        guard let ingreds: [Ingredient] = dbDelegate.mapCocktailInventory(ingredientIDs: ingredientPointers) else {fatalError("ingreds not assigned")}
        
        self.init(name: name, about: about, description: description , instructions: instructions, ingredients: ingreds, image: image)
    }
}


// MARK: - Ingredient Struct

struct Ingredient: Hashable {
    
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
        case GingerBeer = "Ginger Beer"
        case Campari
        case Conteou
        case Vermouth
        case Pisco
        case Cointreau
        case Water
        case Prosecco
        case Liqueur
        case Curacao
        case Benedictine
        case orangeliqueur = "Orange Liqueur"
        case amarettoliqueur = "Amaretto Liqueur"
        case coffeeliqueur = "Coffee Liqueur"
        case cherryliqueur = "Cherry Liqueur"
        case cocunutrum = "Coconut Rum"
        case simplesyrup = "Simple Syrup"
        case Lime
        case eggwhite = "Egg White"
        case limejuice = "Lime Juice"
        case clubsoda = "Club Soda"
        case groundblackpepper = "Ground Black Pepper"
        case Horseradish
        case smokedpaprika = "Smoked Paprika"
        case lemonjuice = "Lemon Juice"
        case worcestershire = "Worcestershire Sauce"
        case celeray = "Celery Salt"
        case pey = "Peychaud's Bitters"
        case Sugar
        case tabasco = "Tabasco Sauce"
        case tomatojuice = "Tomato Juice"
        case Lemon
//        case worcestershire
        case Other
    }
    
    let name: String
    let category: category
    let image: URL
    let id: String
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "category" : self.category.rawValue,
            "image" : image.absoluteString
        ]
    }
}

extension Ingredient: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let category = Ingredient.category(rawValue: ((dictionary["category"] as! String).capitalized)),
            let id = dictionary["id"] as? String,
            let image = (dictionary["image"] as? String).flatMap(URL.init(string:))//,
            //            let measurement = dictionary["measurement"] as? String,
            //            let amount = dictionary["amount"] as? Double
            else { return nil }
        
        self.init(name: name, category: category, image: image, id: id)//, measurement: measurement, amount: amount)
    }
}




// MARK: - Non-Important

//    // Default constructor with nearly empty values
//    init() {
//        self.name = ""
//        self.about = ""
//        self.image = URL(string: "https://1570308986.rsc.cdn77.org/wp-content/uploads/2016/12/DSC_1447.jpg")!
//        self.description = ""
//        self.instructions = []
//        self.ingredients = []
//    }
//
//    // Constructor with default values
//    init(name: String,
//         about: String = defaultLongText,
//         description: String = defaultMediumText,
//         instructions: [String] = defaultInstructions,
//         ingredients:[Ingredient] = dbDelegate.getUserIngredients(),
//         image: URL = URL(string: "https://1570308986.rsc.cdn77.org/wp-content/uploads/2016/12/DSC_1447.jpg")!) {
//        self.name = name
//        self.about = about
//        self.image = image
//        self.description = description
//        self.instructions = instructions
//        self.ingredients = ingredients
//    }
