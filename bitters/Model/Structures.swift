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
    let image: UIImage
    
    init(name: String, about: String = defaultLongText, description: String = defaultMediumText, instructions: [String] = [dafaultShortText], ingredients:[Ingredient] = dbDelegate.getUserIngredients(), image: UIImage = UIImage(named: "cellDefault")!) {
        self.name = name
        self.about = about
        self.image = image
        self.description = description
        self.instructions = instructions
        self.ingredients = ingredients
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
