//
//  DatabaseConnection.swift
//  bitters
//
//  Created by Luis Flores on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol dbConnectionDelegate {
    func getUserIngredients() -> [Ingredient]
    func getAllCocktails() -> [Cocktail]
    func getUserInventory()
    func mapCocktailInventory(ingredientIDs: [String]) -> [Ingredient]
    func getAvailableCocktails() -> [Cocktail]
}

var globalIngredients: [Ingredient] = []
var globalUserIngredients: [Ingredient] = []
var globalCocktails: [Cocktail] = []
var currentCells: [Ingredient] = []
var userIngredientsList: [String] = []

var db: Firestore!
var user: Auth!

class DatabaseConnection: dbConnectionDelegate  {
    
    private var listener: ListenerRegistration?
    
    
    init() {
        self.setup()
    }
    
    func setup() {
        db = Firestore.firestore()
        user = Auth.auth()
        query = baseQuery()
        observeQuery()
        print("Initialized DatabseConnection as delegate")
    }
    
    //  MARK: - Database Querying
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
                observeQuery()
            }
        }
    }
    
    fileprivate func observeQuery() {
        guard let query = query else { return }
        stopObserving()
        
        // Display data from Firestore, part one
        
        listener = query.addSnapshotListener { [unowned self] (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            let models = snapshot.documents.map { (document) -> Ingredient in
                var idData = document.data()
                
                idData["id"] = document.documentID
                if let model = Ingredient(dictionary: idData) {
                    return model
                } else {
                    // Don't use fatalError here in a real app.
                    fatalError("Unable to initialize type \(Ingredient.self) with dictionary \(document.data())")
                }
            }
            
            globalIngredients = models
            self.getCocktails()
            self.getUserInventory()
            
            
        }
    }
    
    fileprivate func stopObserving() {
        listener?.remove()
    }
    
    fileprivate func baseQuery() -> Query {
        return db.collection("Ingredients").limit(to: 50)
    }
    
    fileprivate func userIngredientQuery()-> Query {
        return db.collection("UserData")
    }
    
    //    fileprivate func cocktailsQuery() -> Query {
    //        print("Cocktails Query")
    //        return
    //    }
    
    func getCocktails() {
        let cocktailsRef = Firestore.firestore().collection("Cocktails")
        cocktailsRef.getDocuments { (snapshot, error) in
            if error != nil {
                print("Error getting Cocktails")
            } else {
                
                let cocktailModels: [Cocktail] = snapshot!.documents.map { (cocktailDocument) -> Cocktail in
                    
                    let cocktailData = cocktailDocument.data()
                    
                    if let model = Cocktail(dbDictionary: cocktailData) {
                        return model
                    } else {
                        fatalError("Unable to initialize type \(Cocktail.self) with dictionary \(cocktailData)")
                    }
                }
                
                print("cocktails: \(cocktailModels)")
                
                //globalCocktails = cocktailModels
                //self.getAllCocktails()
            }
        }
    }
    
    func mapCocktailInventory(ingredientIDs: [String]) -> [Ingredient] {
        let filteredUserIngredients = globalIngredients.filter { (ingredient) -> Bool in
            // MARK: CHANGE HERE FOR COCKTAILS
            
            return ingredientIDs.contains(ingredient.id)
        }
        return filteredUserIngredients
        
    }
    
    // --- END:
    
    func monitor( tableView: UITableView, query: Query) {
        tableView.reloadData()
    }
    
    func mapUserInventory() {
        let filteredUserIngredients = globalIngredients.filter { (Ingredient) -> Bool in
            // MARK: CHANGE HERE FOR INGREDIENTS
            userIngredientsList.contains(Ingredient.id)
            //true
        }
        globalUserIngredients = filteredUserIngredients
    }
    
    func getUserInventory() {
        let userID = user.currentUser!.uid
        
        db.document("UserData/\(userID)").getDocument { (snapshot, err) in
            
            if let err = err {
                print(err)
            }
            if let userIngredients = snapshot?.data()!["inventory"] as? [String] {
                userIngredientsList = userIngredients
            } else {
                print("Could not get user inventory")
            }
            self.mapUserInventory()
        }
    }
    
    //MARK: - Mock Cocktail Data Array
    
    
    func getAllCocktails() -> [Cocktail] {
        var cocktailArray: [Cocktail] = []
//        cocktailArray.append(Cocktail(name: "Dark n Stormy"))
//        cocktailArray.append(Cocktail(name: "Negroni"))
//        cocktailArray.append(Cocktail(name: "Vodka Sour"))
//        cocktailArray.append(Cocktail(name: "Sake Bomb"))
//        cocktailArray.append(Cocktail(name: "Gibson"))
//        cocktailArray.append(Cocktail(name: "Gin and Tonic"))
//        cocktailArray.append(Cocktail(name: "Gin Sour"))
//        cocktailArray.append(Cocktail(name: "Cojito"))
//        cocktailArray.append(Cocktail(name: "Mojito"))
        
        return globalCocktails
    }
    
    
    // MARK: - Mock Ingredient Data Array
    
    func getUserIngredients() -> [Ingredient] { //This will later be used to pull data info
        
        var cellContents: [Ingredient] = []
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        
        // Old sample data
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
    
    func getDetailedCocktailInfo(name: String) -> Cocktail {
        
        return Cocktail(name: name,
                        about:defaultMediumText,
                        description: defaultLongText,
                        instructions: defaultInstructions,
                        ingredients: defaultIngredients,
                        image: URL(string: "https://1570308986.rsc.cdn77.org/wp-content/uploads/2016/12/DSC_1447.jpg")!)
    }
    
    func getAvailableCocktails() -> [Cocktail] {
        var availableCocktails: [Cocktail] = []
//        availableCocktails.append(Cocktail(name: "Old Fashioned"))
//        availableCocktails.append(Cocktail(name: "Mexican Coffee"))
//        availableCocktails.append(Cocktail(name: "Negroni"))
//        availableCocktails.append(Cocktail(name: "Whiskey Sour"))
//        availableCocktails.append(Cocktail(name: "Manhattan"))
        return globalCocktails
    }
}
