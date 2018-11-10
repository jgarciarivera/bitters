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

