//
//  DatabaseConnection.swift
//  bitters
//
//  Created by Luis Flores on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

let sampleIngredientDictionary: [String: Any] = [
    "name": "The Good Shit",
    "category": "cherry liqueur",
    "image": "https://gangslangs.com/wp-content/uploads/2017/09/alcohol-benefits.jpg",
    "id": "shit"
]

let defaultInstructions = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                           "Vestibulum consequat lacus sit amet tempus mollis.",
                           "Nulla tempor dictum est, et viverra nisi."]

let sampleIngredient = Ingredient(dictionary: sampleIngredientDictionary)!

let defaultIngredients = [sampleIngredient, sampleIngredient, sampleIngredient]

let sampleCocktailDictionary: [String: Any] = [
    "name": "Fucking Good Cocktail",
    "about": defaultLongText,
    "description" : defaultMediumText,
    "instructions" : defaultInstructions,
    "ingredients" : defaultIngredients,
    "image": "https://assets.bonappetit.com/photos/57acc14e53e63daf11a4d9b6/16:9/w_1200,c_limit/whiskey-sour.jpg"
    
]


protocol dbConnectionDelegate {
    func getUserIngredients() -> [Ingredient]
    func getUserCocktails() -> [Cocktail]
}

class DatabaseConnection: dbConnectionDelegate  {
    //I can't pass the array to the function because it can't set the data...
    
    
    
    
    //MARK: - Mock Cocktail Data Array
    
    
    func getUserCocktails() -> [Cocktail] {
        var cocktailArray: [Cocktail] = []
        let sampleCocktail = Cocktail(dictionary: sampleCocktailDictionary)!
        cocktailArray.append(sampleCocktail)
        cocktailArray.append(sampleCocktail)
        cocktailArray.append(sampleCocktail)
        cocktailArray.append(sampleCocktail)
//        cocktailArray.append(Cocktail(name: "Negroni"))
//        cocktailArray.append(Cocktail(name: "Vodka Sour"))
//        cocktailArray.append(Cocktail(name: "Sake Bomb"))
//        cocktailArray.append(Cocktail(name: "Gibson"))
//        cocktailArray.append(Cocktail(name: "Gin and Tonic"))
//        cocktailArray.append(Cocktail(name: "Gin Sour"))
//        cocktailArray.append(Cocktail(name: "Cojito"))
//        cocktailArray.append(Cocktail(name: "Mojito"))
        
        return cocktailArray
    }
    
    
    // MARK: - Mock Ingredient Data Array
    
    func getUserIngredients() -> [Ingredient] { //This will later be used to pull data info
        
        var cellContents: [Ingredient] = []
        let ingredient = sampleIngredient
        cellContents.append(ingredient)
        cellContents.append(ingredient)
        cellContents.append(ingredient)
        cellContents.append(ingredient)
        cellContents.append(ingredient)
//        cellContents.append(Ingredient(name: "New Amsterdam", category: Ingredient.category.Vodka))
//        cellContents.append(Ingredient(name: "Pepitos's Añejo", category: Ingredient.category.Tequila))
//        cellContents.append(Ingredient(name: "Grey Goose", category: .Vodka))
//        cellContents.append(Ingredient(name: "Tanqueray", category: .Gin))
//        cellContents.append(Ingredient(name: "Malibu", category: .Rum))
//        cellContents.append(Ingredient(name: "Crown Royal", category: .Whiskey))
//        cellContents.append(Ingredient(name: "Jose Cuervo", category: .Tequila))
//        cellContents.append(Ingredient(name: "Johnnie Walker", category: .Whiskey))
//        cellContents.append(Ingredient(name: "Hennessy", category: .Cognac))
//        cellContents.append(Ingredient(name: "Casadores", category: .Tequila))
        
        return cellContents
    }
    
    
//    func getCocktails() -> [Cocktail] {
//
//        //Initializing Connection
//        let db = Firestore.firestore() //Firestore
//        db.settings.areTimestampsInSnapshotsEnabled = true
//
//        // Array to collect
//        var allCocktails: [Cocktail] = []
//
//        db.collection(dbcollections.Recipes.rawValue).getDocuments() { (snapshot, error) in
//            if let error = error {
//                print("Could not get documents: \(error)")
//            } else {
//                for document in snapshot!.documents {
//
//                    // Accessing Ingredients
//                    db.collection(dbcollections.Recipes.rawValue).document(document.documentID).collection("ingredients").getDocuments(completion: { (docSnap, eror) in
//
//                        //Collect Cocktail Ingredient
//                        var ingredients: [Ingredient] = []
//
//
////                        print("Document Name: \(document.data()["name"]!)")
////                        print("Document ID: \(document.documentID)")
////                        print("Data: \(document.data())\n\n")
//
//                        if let error = error {
//                            print("Could not get ingredients document: \(error)")
//                        } else {
//
////                            print("Ingredients: ")
//                            for ingredientDoc in docSnap!.documents {
////                                print("\t Ingredient Data: \(ingredientDoc.data())")
//                                let ingredientData = ingredientDoc.data()
//
//                                var image: UIImage? = nil
//
//                                if let imageString = ingredientData["image"] as? String {
//                                    let url = URL(string: imageString)
//                                    image = loadFromURL(url: url!)
//                                }
//                                // let url = URL(string: ingredientData["image"] as! String)!
//                                //let image:UIImage = loadFromURL(url: url)
//                                //
//
//                                let myCategory = Ingredient.category(rawValue: (ingredientData["category"] as! String).capitalized)!
//
//                                let lclIngredient:Ingredient = Ingredient(
//                                    name: ingredientData["name"] as! String,
//                                    category: myCategory,
//                                    image: image ?? UIImage(named: "cellDefault")!,
//                                    measurement: ingredientData["measurement"] as! String,
//                                    amount: ingredientData["amount"] as? Double ?? Double(ingredientData["amount"] as! String)!
//                                )
//
////                                print(lclIngredient)
//
//                                ingredients.append(lclIngredient);
//                            }
//                            //print("\n\n")
//                        }
//                        let cocktailData = document.data()
//
//                        let url = URL(string: cocktailData["image"] as! String)!
//                        let cocktailImage:UIImage = loadFromURL(url: url)
//
//                        let newCocktail = Cocktail(
//                            name: cocktailData["name"]! as! String,
//                            about: cocktailData["longDescription"]! as! String,
//                            description: cocktailData["shortDescription"]! as! String,
//                            instructions: cocktailData["instructions"] as? [String] ?? ["No instructions"],
//                            ingredients: ingredients,
//                            image: cocktailImage)
//
//                        allCocktails.append(newCocktail)
//
//                        print("In funtion \(allCocktails)")
//
//                    })
//                }
//            }
//
//
//
//        }
//        return allCocktails
//    }
    
 
//    //Messing Around
//    let db = Firestore()
//
//    db.collection("recipes").getDocuments() { (querySnapshot, err) in
//    if let err = err {
//    print("Error getting recipes: \(err)")
//    } else {
//    for recipe in querySnapshot!.documents {             //iterate through each cocktail in recipes
//
//
//
//    var matchedIngredients
//    document.collection("ingredients").getDocuments() { (querySnapshot, err) in
//    if let err = err {
//    print("Error getting recipes: \(err)")
//    } else {
//    for document in querySnapshot!.documents {
//    // if userIngredients struct contains document.get("name") and userIngredients.amountOfIngredient > document.get("amount")
//    //matchedIngredients += 1
//    }
//    }
//
//    }
//    }
//    }
//    }
}

//func getImage(URL: String) {
//    URLSession.shared.dataTask(with: URL, completionHandler: { (data, response, error) in
//        if error != nil {
//            print(error!)
//            return UIImage(named: defaultCell)
//        }
//        DispatchQueue.main.async {
//            return UIImage(data: data!)
//        }
//    }).resume()
//}



    func loadFromURL(url: URL) -> UIImage {
        
        var localImage: UIImage?
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        localImage = image
                    }
                }
            }
        }
        
        return localImage ?? UIImage(named: "cellDefault")!
    }


