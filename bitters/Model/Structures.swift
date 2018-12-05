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

let defaultLongText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in, semper lacinia nisl. Mauris erat ex, dictum vitae purus ac, interdum ornare lacus. Nulla tempor dictum est, et viverra nisi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut semper sem nulla, nec sagittis turpis vehicula quis. Sed ac nulla nec neque interdum consequat. Morbi tristique augue elit. Nunc rutrum purus et risus ultricies mattis. Etiam fermentum pulvinar posuere."
let defaultMediumText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in, semper lacinia nisl. Mauris erat ex, dictum vitae purus ac, interdum ornare lacus. Nulla tempor dictum est, et viverra nisi."
let dafaultShortText = "Lorem ipsum dolor sit amet."


//MARK: - Cocktail Struct

let dbDelegate: dbConnectionDelegate = DatabaseConnection()

struct Cocktail {
    let name: String
    let about: String
    let description: String
    let instructions: [String]
    let ingredients: [Ingredient]
    let image: URL
    
//    init(name: String, about: String = defaultLongText, description: String = defaultMediumText, instructions: [String] = [dafaultShortText], ingredients:[Ingredient] = dbDelegate.getUserIngredients(), image: UIImage = UIImage(named: "cellDefault")!) {
//        self.name = name
//        self.about = about
//        self.image = image
//        self.description = description
//        self.instructions = instructions
//        self.ingredients = ingredients
//    }
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
}


// MARK: - Ingredient Struct

struct Ingredient {
    
    enum category: String, CaseIterable {
        //Still need to add categories from Kristian
        case Rum
        case Vodka
        case Tequila
        case Gin
        case Whiskey
        case Brandy
        case Cognac
        case Absinthein
        case Aperol
        case Mezcal
        case Soju
        case Bourbon
        case GingerBeer = "Ginger Beer"
        case Campari
        case Conteou
        case Vermouth
        case Scotch
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
    
//    let measurement: String
//    let amount: Double
    
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
