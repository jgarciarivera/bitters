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
import FirebaseAuth


// MARK: - Cell Contents Structure
//This can later be globalized if necessary

class InventoryViewController: UIViewController {
    func updateData() {
        print("updateData() called")
    }
    
    var dbdelegate = dbConnection
    
    // Database
    
    // Data to Populate View
    let backgroundView = UIImageView()
    var ingredients: [Ingredient] = []
    //private var listener: ListenerRegistration?
    let screenHeight = UIScreen.main.bounds.height
    var scrollViewContentHeight = 1400 as CGFloat
    
    // MARK: - View Controller Objects
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
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
        
//        db = Firestore.firestore()
//        user = Auth.auth()
        
        backgroundView.image = UIImage(named: "Cocktail Illustration")
        
        backgroundView.contentScaleFactor = 2
        backgroundView.contentMode = .bottom
        inventoryTable.backgroundView = backgroundView
        inventoryTable.tableFooterView = UIView()
        inventoryTable.rowHeight = UITableView.automaticDimension
        inventoryTable.estimatedRowHeight = 140
        
        
        inventoryTable.dataSource = self
        inventoryTable.delegate = self
        
        
        // adjust scroll view
        scrollView.delegate = self
        inventoryTable.delegate = self
        inventoryTable.dataSource = self
        scrollView.bounces = false
        inventoryTable.bounces = false
        inventoryTable.isScrollEnabled = false
        inventoryTable.separatorStyle = .none

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: DATAB
    
        // Need to set data locally....
    
    // MARK: TABLE VIEW
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.viewHeight.constant = self.inventoryTable.contentSize.height + self.imageHeight.constant + 50
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if scrollView == self.scrollView {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                inventoryTable.isScrollEnabled = true
            }
        }
        
        if scrollView == self.inventoryTable {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.inventoryTable.isScrollEnabled = false
            }
        }
    }
    
}

extension InventoryViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    //  MARK: - Table View Funtion
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalUserIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? InventoryCell else {
            return UITableViewCell()
        }
        
        let ingredient = globalUserIngredients[indexPath.row]
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


