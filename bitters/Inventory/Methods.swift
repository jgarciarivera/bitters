//
//  Date.swift
//  bitters
//
//  Created by Luis Flores on 10/30/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import Foundation
import UIKit
import Firebase


//MARK: - Default Texts as a reference for defaultValues of Cocktail Struct

let defaultLongText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in, semper lacinia nisl. Mauris erat ex, dictum vitae purus ac, interdum ornare lacus. Nulla tempor dictum est, et viverra nisi. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut semper sem nulla, nec sagittis turpis vehicula quis. Sed ac nulla nec neque interdum consequat. Morbi tristique augue elit. Nunc rutrum purus et risus ultricies mattis. Etiam fermentum pulvinar posuere."
let defaultMediumText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consequat lacus sit amet tempus mollis. Ut nibh justo, bibendum vel leo in, semper lacinia nisl. Mauris erat ex, dictum vitae purus ac, interdum ornare lacus. Nulla tempor dictum est, et viverra nisi."
let dafaultShortText = "Lorem ipsum dolor sit amet."

//MARK: - Cocktail Struct

struct Cocktail {
    let name: String
    let about: String
    let description: String
    let instructions: [String]
    let ingredients: [Ingredient]
    let image: UIImage
    
    init(name: String, about: String = defaultLongText, description: String = defaultMediumText, instructions: [String] = [dafaultShortText], ingredients:[Ingredient] = updateIngredientCellContent(), image: UIImage = UIImage(named: "cellDefault")!) {
        self.name = name
        self.about = about
        self.image = image
        self.description = description
        self.instructions = instructions
        self.ingredients = ingredients
    }
}

//MARK: - Mock Cocktail Data Array

func updateCocktailCellContent() -> [Cocktail] {
    var cocktailArray: [Cocktail] = []
    cocktailArray.append(Cocktail(name: "Dark n Stormy"))
    cocktailArray.append(Cocktail(name: "Negroni"))
    cocktailArray.append(Cocktail(name: "Vodka Sour"))
    cocktailArray.append(Cocktail(name: "Sake Bomb"))
    cocktailArray.append(Cocktail(name: "Gibson"))
    cocktailArray.append(Cocktail(name: "Gin and Tonic"))
    cocktailArray.append(Cocktail(name: "Gin Sour"))
    cocktailArray.append(Cocktail(name: "Cojito"))
    cocktailArray.append(Cocktail(name: "Mojito"))
    
    return cocktailArray
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

// MARK: - Mock Ingredient Data Array

func updateIngredientCellContent() -> [Ingredient] { //This will later be used to pull data info
    
    var cellContents: [Ingredient] = []
    cellContents.append(Ingredient(name: "New Amsterdam", category: Ingredient.category.Vodka))
    cellContents.append(Ingredient(name: "Pepitos's Añejo", category: Ingredient.category.Tequila))
    cellContents.append(Ingredient(name: "Grey Goose", category: .Vodka))
    cellContents.append(Ingredient(name: "Tanqueray", category: .Gin))
    cellContents.append(Ingredient(name: "Malibu", category: .Rum))
    cellContents.append(Ingredient(name: "Crown Royal", category: .Whiskey))
    cellContents.append(Ingredient(name: "Jose Cuervo", category: .Tequila))
    cellContents.append(Ingredient(name: "Johnnie Walker", category: .Whiskey))
    cellContents.append(Ingredient(name: "Hennessy", category: .Cognac))
    cellContents.append(Ingredient(name: "Casadores", category: .Tequila))
    
    return cellContents
}


// MARK: - Database Stuff & Random Methods

enum dbcollections: String {
    case UserData
    case Recipes = "Recipies"
}

func addNewIngredient(ingredientToBeAdded: Ingredient) {
    print("Called addNewIngredient... \n\(ingredientToBeAdded.name)")
}

func currentUser() {
//    let db = Firestore.firestore() //Firestore
//    db.settings.areTimestampsInSnapshotsEnabled = true
//    
//    let userID = Auth.auth().currentUser!.uid
//    
//    db.collection(dbcollections.UserData.rawValue).document(userID).setData([
//        "name": "Luis",
//        "last":"Flores",
//        "dog": [
//            "name": "Dusty",
//            "middle": "Jay",
//            "last": "Enciso",
//        ]
//        ], merge: true)
//    
//    
//    db.collection(dbcollections.Recipes.rawValue).getDocuments() { (snapshot, error) in
//        if let error = error {
//            print("Error getting documents \(error.localizedDescription)")
//        } else {
//            for document in snapshot!.documents {
//                print(document.documentID)
//                print(document.data())
//            }
//        }
//    }
    
//    db.collection("Recipies").getDocuments() { (snapshot, error) in
//        if let error = error {
//            print("Could not get documents: \(error)")
//        } else {
//            for document in snapshot!.documents {
//                print("Document Name: \(document.documentID)")
//                print("Data: \(document.data())\n")
//            }
//        }
//
//    }
    
}

