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
import FirebaseFirestore

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

func updateCellContent() -> [Ingredient] { //This will later be used to pull data info
    
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


// Mark: - Database Handling




func addNewIngredient(ingredientToBeAdded: Ingredient) {
    print("Called addNewIngredient... \n\(ingredientToBeAdded.name)")
    if( true) {
        enum hello {
            case mym
            case luck
        }
    }
}

enum dbcollections: String {
    case UserData
    case Recipes = "Recipies"
}

func currentUser() {
    let db = Firestore.firestore() //Firestore
    db.settings.areTimestampsInSnapshotsEnabled = true
    
    let knownUID = "yRCNQg6ATkfnSFApp40P3ugwv1k1"
    
    //let ref = Database.database().reference() //Real-time
    
    let userID: String!
    userID = Auth.auth().currentUser?.uid
    
    
    db.collection(dbcollections.UserData.rawValue).document(userID).setData([
        "name": "Luis",
        "last":"Flores",
        "dog": [
            "name": "Dusty",
            "middle": "Jay",
            "last": "Enciso",
        ]
        ], merge: true)
    
    
    db.collection(dbcollections.Recipes.rawValue).getDocuments() { (snapshot, error) in
        if let error = error {
            print("Error getting documents \(error.localizedDescription)")
        } else {
            for document in snapshot!.documents {
                print(document.documentID)
                print(document.data())
            }
        }
    }
        
    
    
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
    
    print("Current UID: \(userID!)")
    print(userID == knownUID)
    
}

