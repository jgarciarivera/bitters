//
//  InventoryViewController.swift
//  bitters
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase


// MARK: - Cell Contents Structure
//This can later be globalized if necessary

var entireCells: [Ingredient] = []
var currentCells: [Ingredient] = []

class InventoryViewController: UIViewController {
    var dbdelegate = DatabaseConnection()
    
    // Database
    var db: Firestore!
    var user: Auth!
    
    // Data to Populate View
    let backgroundView = UIImageView()
    var ingredients: [Ingredient] = []
    var userIngredientsList: [String] = []
    private var listener: ListenerRegistration?

    
    // MARK: - View Controller Objects
    @IBOutlet weak var inventoryTable: UITableView!
    @IBOutlet weak var inventorySearchBar: UISearchBar!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    @IBAction func addIngredient(_ sender: Any) {
        performSegue(withIdentifier: "addIngredientSegue", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        currentUser()
        inventoryTable.separatorStyle = .none
        stylizeAddIngredientButton()
//        entireCells = dbdelegate.getUserIngredients()
//        currentCells = currentCells.isEmpty ? entireCells : currentCells
        
        
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

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
            
            self.ingredients = models
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
        print("User Data Query!")
        return db.collection("UserData")
    }
    
    func monitor( tableView: UITableView, query: Query) {
        tableView.reloadData()
    }
    
    func mapUserInventory() {
        let filteredUserIngredients = self.ingredients.filter { (Ingredient) -> Bool in
            // MARK: CHANGE HERE FOR INGREDIENTS
            self.userIngredientsList.contains(Ingredient.id)
            //true
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
    
    
    
    
    
}

extension InventoryViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    //  MARK: - Table View Funtion
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? InventoryCell else {
            return UITableViewCell()
        }
        
        let ingredient = self.ingredients[indexPath.row]
        cell.populate(ingredient: ingredient)
        
        return cell
    }
    
    //MARK: - Swipe Delete Action
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let delete = deleteAction(at: indexPath)
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
    
//    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
//        let ingredient = currentCells[indexPath.row]
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
//            entireCells.remove(at: indexPath.row)
//
//            completion(true)
//        }
//        return action
//    }
    
    // MARK: - SearchBar Functionality For now
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)
//
//        let containsString: (Ingredient, String) -> Bool = { (ingredient, searchText) in
//            ingredient.name.lowercased().contains(searchText.lowercased()) || ingredient.category.rawValue.lowercased().contains(searchText.lowercased())
//        }
//
//        currentCells = !searchText.isEmpty ? entireCells.filter { containsString($0, searchText) } : entireCells
//        inventoryTable.reloadData()
//    }
    
    func stylizeAddIngredientButton() {
        addIngredientButton.layer.cornerRadius = addIngredientButton.frame.height/2
        addIngredientButton.layer.shadowOpacity = 0.3
        addIngredientButton.layer.shadowRadius = 4
        addIngredientButton.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
}


