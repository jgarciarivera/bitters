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
        
//        categoriesToAdd.forEach { (data) in
//            addIngredientCategories(category: data)
//        }
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
                
                globalCocktails = cocktailModels
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
    
    
    
//    func addIngredientCategories(category: [String: Any]) {
//        let ingRef = db.collection("Ingredients").addDocument(data: category)
//    }
}


//let categoriesToAdd = [
//
//    ["category": "ginger beer", "name": "Ginger Beer", "image": "https://i0.wp.com/drinkingginger.com/wp-content/uploads/2017/12/Barritts_full_700x1000.jpg?resize=700%2C1000"],
//
//    ["category": "vodka", "name": "Vodka", "image": "https://www.firstchoiceliquor.com.au/-/media/Images/Products/Generic_SpiritBottle.ashx?bc=White&mh=200&w=200&productID=2125390&isThumbnail=False&hash=6BEFEBE242820A4C65F443333E2AED1EC894BF6C"],
//    ["category": "lime juice", "name": "Lime Juice", "image": "https://www.firstchoiceliquor.com.au/-/media/Images/Products/Generic_SpiritBottle.ashx?bc=White&mh=200&w=200&productID=2125390&isThumbnail=False&hash=6BEFEBE242820A4C65F443333E2AED1EC894BF6C"],
//    ["category": "lime", "name": "Lime", "image": "https://static.meijer.com/Media/000/41409/0004140900006_0_A1C1_0600.png"],
//    ["category": "rum", "name": "Rum", "image": "https://static1.squarespace.com/static/56ce21152fe1314d29719fb4/t/5a66d34a24a69492e7c82f65/1516688222320/below-deck-spice-rum-lg.jpg"],
//    ["category": "simple syrup", "name": "Simple Syrup", "image": "https://products2.imgix.drizly.com/ci-dailys-bar-syrup-e808676d45be517a.jpeg?auto=format%2Ccompress&fm=jpeg&q=20"],
//    ["category": "egg white", "name": "Egg White", "image": "http://joepastry.com/pics/eggwhite.jpg"],
////    ["category": "lemon juice", "name": "Lemon Juice", "image": "https://static.meijer.com/Media/000/41409/0004140900005_0_A1C1_0600.png"],
//    ["category": "gin", "name": "Gin", "image": "https://okanaganspirits.com/wp-content/uploads/2017/03/OS-Gin-Essential-Collection-HR.jpg"],
//    ["category": "club soda", "name": "Club Soda", "image": "https://static.meijer.com/Media/007/13733/0071373367451_0_A1C1_0600.png"],
//
//
//    ["category": "ground black pepper", "name": "Ground Black Pepper", "image": "https://target.scene7.com/is/image/Target/GUEST_8f56133a-a671-4150-962e-95dcc9f64c5c?wid=488&hei=488&fmt=pjpeg"],
//    ["category": "smoked paprika", "name": "Smoked Paprika", "image": "https://target.scene7.com/is/image/Target/GUEST_7a335e6b-ffa2-4887-8476-f77302ab6298?wid=488&hei=488&fmt=pjpeg"],
//    ["category": "lemon", "name": "Lemon", "image": "https://images-na.ssl-images-amazon.com/images/I/81UzOaQ6VyL._SY355_.jpg"],
//    ["category": "worcestershire sauce", "name": "Worcestershire Sauce", "image": "https://target.scene7.com/is/image/Target/GUEST_9d682c66-dada-4057-8f05-d45b6191e4e5?wid=488&hei=488&fmt=pjpeg"],
//    ["category": "tabasco sauce", "name": "Tabasco Sauce", "image": "https://target.scene7.com/is/image/Target/GUEST_188462a0-c26b-41aa-91c9-a9f46661b496?wid=488&hei=488&fmt=pjpeg"],
//    ["category": "horseradish", "name": "Horseradish", "image": "https://static.meijer.com/Media/000/38882/0003888272002_0_A1C1_0600.png"],
//    ["category": "tomato juice", "name": "Tomato Juice", "image": "https://www.dollargeneral.com/media/catalog/product/cache/image/beff4985b56e3afdbeabfc89641a4582/9/2/928301.jpg"],
//    ["category": "celery salt", "name": "Celery Salt", "image": "https://target.scene7.com/is/image/Target/GUEST_4c31ceb3-818e-4554-b828-9a3a9f1110af?wid=488&hei=488&fmt=pjpeg"],
//    ["category": "sugar", "name": "Sugar", "image": "https://images.samsclubresources.com/is/image/samsclub/0004920004754_A?$img_size_380x380$"],
//    ["category": "peychaud's bitters", "name": "Peychaud's Bitters", "image": "https://images-na.ssl-images-amazon.com/images/I/61w172t7OBL._SY355_.jpg"],
//    ["category": "cognac", "name": "Cognac", "image": "https://cdn11.bigcommerce.com/s-erpoah/images/stencil/1280x1280/products/9020/13505/courvoisier-vs-french-cognac-bottle-1000ml__67531.1494823439.jpg?c=2&imbypass=on"],
//
//
//    ["category": "angostura bitters", "name": "Angostura Bitters", "image": "https://images-na.ssl-images-amazon.com/images/I/61w1qatvV%2BL._SY355_.jpg"],
//    ["category": "water", "name": "Water", "image": "https://cdn.instructables.com/FU2/Y18R/IDM04U7M/FU2Y18RIDM04U7M.LARGE.jpg"],
//    ["category": "whiskey", "name": "Whiskey", "image": "https://products2.imgix.drizly.com/ci-jack-daniels-tennessee-honey-1d9700d15d455076.jpeg?auto=format%2Ccompress&dpr=2&fm=jpeg&h=240&q=20"],
//    ["category": "orange bitters", "name": "Orange Bitters", "image": "https://cdnimg.webstaurantstore.com/images/products/large/80373/55428.jpg"],
//    ["category": "vermouth", "name": "Vermouth", "image": "https://s7d9.scene7.com/is/image/SAQ/11544302_is?$saq%2Dprod%2Dtra$"],
//    ["category": "campari", "name": "Campari", "image": "https://applejack.com/site/images/Campari-Aperitivo-750-ml_1.png"],
//    ["category": "orange", "name": "Orange", "image": "http://soappotions.com/wp-content/uploads/2017/10/orange.jpg"],
//    ["category": "scotch", "name": "Scotch", "image": "https://products2.imgix.drizly.com/ci-johnnie-walker-red-label-6f6a8b0c1568ddb1.jpeg?auto=format%2Ccompress&dpr=2&fm=jpeg&h=240&q=20"],
//    ["category": "honey-ginger syrup", "name": "Honey-Ginger Syrup", "image": "https://static.meijer.com/Media/007/44160/0074416020061_0_A1C1_0600.png"],
//    ["category": "cointreau", "name": "Cointreau", "image": "https://products3.imgix.drizly.com/ci-cointreau-5e1f534418e40c4b.png?auto=format%2Ccompress&fm=jpeg&q=20"],
//    ["category": "bourbon", "name": "Bourbon", "image": "https://products2.imgix.drizly.com/ci-bulleit-bourbon-07be0e5c0084bc44.jpeg?auto=format%2Ccompress&dpr=2&fm=jpeg&h=240&q=20"],
//
//    ["category": "prosecco", "name": "Prosecco", "image": "https://static.vinepair.com/wp-content/uploads/2017/11/La-Marca.jpg"],
//    ["category": "aperol", "name": "Aperol", "image": "https://www.ocado.com/productImages/949/94934011_0_640x640.jpg?identifier=bf0b3cd378a75f7a5f3f1dc166af23c3"],
//    ["category": "benedictine", "name": "Benedictine", "image": "https://cdn11.bigcommerce.com/s-e6b77/images/stencil/1280x1280/products/15082/15450/benedictine-dom__88697.1496359865.jpg?c=2"],
//    ["category": "cherry", "name": "Cherry", "image": "https://static01.nyt.com/newsgraphics/2014/06/16/bittman-eat-cherry/ed5c4f4c098cd142650d7c00014e71abf85d2f86/eatopener_cherry.jpg"],
//    ["category": "mint", "name": "Mint", "image": "https://cdn.shopify.com/s/files/1/0562/4205/products/mint.jpg?v=1511809558"],
//    ["category": "tequila", "name": "Tequila", "image": "https://cdn1.wine-searcher.net/images/labels/34/31/patron-tequila-anejo-mexico-10653431.jpg"],
//    ["category": "agave syrup", "name": "Agave Syrup", "image": "https://i3.pureformulas.net/images/product/large/ojio-agave-nectar-clear-raw-100-organic-500-ml-by-ultimate-superfoods.jpg"],
//    ["category": "orange liqueur", "name": "Orange Liqueur", "image": "https://applejack.com/site/images/Gran-Gala-Triple-Orange-Liqueur_main-1.png"],
//    ["category": "pisco", "name": "Pisco", "image": "http://cdn.shopify.com/s/files/1/0655/7109/products/Pisco-White_grande.gif?v=1507863925"],
//    ["category": "almond syrup", "name": "Almond Syrup", "image": "https://images-na.ssl-images-amazon.com/images/I/51976%2BQ8EAL._SL1000_.jpg"]
//]
