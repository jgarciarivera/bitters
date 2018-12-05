//
//  InventoryViewController.swift
//  bitters
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

// TODO: Edit ingredient
// TODO: Add ingredient to object
// TODO: Delete ingredient

// Mark: Need an update method for Database
// Push Single
// Push New
// Remove

import UIKit
import FirebaseFirestore
import Firebase

let globalIngredients: [Ingredient] = []


// MARK: - Cell Contents Structure
//This can later be globalized if necessar

class InventoryViewController: UIViewController {
    
    
    // This adds ingredient to Ingredients Collection
    func addIngredientToDatabase(ingredient: Ingredient) {
        let ingredientsRef = self.db.collection("Ingredients")
        ingredientsRef.addDocument(data: ingredient.dictionary) { (err) in
            if err != nil {
                print("Was not able to add ingredient: \(ingredient.dictionary)")
            }
        }
    }
    
    // Need to finish ingredient reference to userData
    func addIngredientToUser(ingredient: Ingredient) {
        let ingredientID: [String: Any] = [ "id": ingredient.id]
        let userRef = self.db.document("UserData/\(user.currentUser!.uid)")
        return
    }
    
    
    
    // MARK: - Handling Local Data
    // I don't need all of the users data, but I do for cocktails
    // var cocktailDocuments: [DocumentReference]? = []
    
    // Database Declaration
    var db: Firestore!
    var user: Auth!
    
    
    var localCollection: LocalCollection<Ingredient>!
    
    // Start Paste
    let backgroundView = UIImageView()
    var ingredients: [Ingredient] = []
    var userIngredientsList: [String] = []
    var userIngredientDocumentsReference: [DocumentSnapshot?] = []
//    private var UserDocument: DocumentSnapshot?
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
                observeQuery()
            }
        }
    }
    
    private var listener: ListenerRegistration?
    // Need to go a bit deaper than just the users here, need to get user ID and then return
    // required data
    
    fileprivate func nameToIngredient(named name: String, category: String) -> Ingredient {
        return globalIngredients.filter { (Ingredient) -> Bool in
            return Ingredient.name == name
            }.first ?? Ingredient(name: name, category: .Other, image: URL(string: "https://1570308986.rsc.cdn77.org/wp-content/uploads/2016/12/DSC_1447.jpg")! , id: "id"  )
    }
    
    fileprivate func observeQuery() {
        guard let query = query else { return }
        stopObserving()
        
        // Display data from Firestore, part one
        
        // Fresh Copy
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
            
            self.ingredients = models
            self.getUserInventory()
//
//            let hey = Firestore.firestore().collection("Ingredient").whereField(FieldPath.documentID(), isEqualTo: "3xsVRFgadGmPURsdfqtY")
//                hey.getDocuments(completion: { (snapshot, error) in
//                    models = (snapshot?.documents.map({ (document) -> Ingredient in
//                        if let model = Ingredient(dictionary: document.data()) {
//                            return model
//                        }  else {
//                            fatalError("Unable to initialize type \(Ingredient.self) with dictionary \(document.data())")
//                        }
//                    }))!
//                })
            
//                self.userIngredientDocumentsReference = snapshot.documents
//
//                if self.userIngredientDocumentsReference.count > 0 {
//                    self.inventoryTable.backgroundView = nil
//                } else {
//                    self.inventoryTable.backgroundView = self.backgroundView
//                }
//
//                self.inventoryTable.reloadData()
        }
    }
    
    fileprivate func stopObserving() {
        listener?.remove()
    }
    
    fileprivate func baseQuery() -> Query {
        return db.collection("Ingredients").limit(to: 50)
    }
    
    fileprivate func userIngredientQuery()-> Query {
        print("User Data Query!")
        return db.collection("UserData")
    }
    
    var dbdelegate = DatabaseConnection()
    
    // MARK: - View Controller Objects
    @IBOutlet weak var inventoryTable: UITableView!
    @IBOutlet weak var inventorySearchBar: UISearchBar!
    
    
    func monitor( tableView: UITableView, query: Query) {
        tableView.reloadData()
    }
    
    func mapUserInventory() {
        let filteredUserIngredients = self.ingredients.filter { (Ingredient) -> Bool in
            self.userIngredientsList.contains(Ingredient.id)
        }
        self.ingredients = filteredUserIngredients
        self.inventoryTable.reloadData()
    }
    
    func getUserInventory() {
        let userID = user.currentUser!.uid
        
        db.document("UserData/\(userID)").getDocument { (snapshot, err) in
            if let err = err {
                print(err)
            }
            if let userIngredients = snapshot?.data()!["inventory"] as? [String] {
                self.userIngredientsList = userIngredients
                print(userIngredients)
            } else {
                print("Could not get user inventory")
            }
            self.mapUserInventory()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        user = Auth.auth()
        
        backgroundView.image = UIImage(named: "Cocktail Illustration")
        
        backgroundView.contentScaleFactor = 2
        backgroundView.contentMode = .bottom
        inventoryTable.backgroundView = backgroundView
        inventoryTable.tableFooterView = UIView()
        inventoryTable.rowHeight = UITableView.automaticDimension
        inventoryTable.estimatedRowHeight = 140
        
        
        query = baseQuery()
        inventoryTable.dataSource = self
        inventoryTable.delegate = self

        observeQuery()

//        ingredients = dbdelegate.getUserIngredients()
//        ingredients = ingredients.isEmpty ? entireCells : ingredients
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addIngredientSegue", sender: self)
    }

}

// MARK: - Tableview Datasource

extension InventoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? InventoryCell else {
            return UITableViewCell()
        }
        
        let ingredient = self.ingredients[indexPath.row]
        cell.populate(ingredient: ingredient)
        
        return cell
    }
    
    //MARK: -  Table Swipe Delete Action
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            // TODO: Remove ingredient from database
            self.ingredients.remove(at: indexPath.row)
//            self.ingredients = self.entireCells
            
            completion(true)
        }
    }
    
}

// MARK: - SearchBar
//extension InventoryViewController: UISearchBarDelegate {
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)
//        
//        let containsString: (Ingredient, String) -> Bool = { (ingredient, searchText) in
//            ingredient.name.lowercased().contains(searchText.lowercased()) || ingredient.category.rawValue.lowercased().contains(searchText.lowercased())
//        }
//        
//        ingredients = !searchText.isEmpty ? entireCells.filter { containsString($0, searchText) } : entireCells
//        inventoryTable.reloadData()
//    }
//    
//}

// TODO: Keep or Remove
//extension InventoryViewController: dbConnectionDelegate{
//    func getUserIngredients() -> [Ingredient] {
//        <#code#>
//    }
//
//    func getUserCocktails() -> [Cocktail] {
//        <#code#>
//    }
//
//
//}


