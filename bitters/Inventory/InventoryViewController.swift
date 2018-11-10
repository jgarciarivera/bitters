//
//  InventoryViewController.swift
//  bitters
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit


// MARK: - Cell Contents Structure
//This can later be globalized if necessary

var entireCells: [Ingredient] = []
var currentCells: [Ingredient] = []

class InventoryViewController: UIViewController {
    var dbdelegate: dbConnectionDelegate?
    
    // MARK: - View Controller Objects
    @IBOutlet weak var inventoryTable: UITableView!
    @IBOutlet weak var inventorySearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser()
        entireCells = dbdelegate!.getUserIngredients()
        currentCells = currentCells.isEmpty ? entireCells : currentCells
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addIngredientSegue", sender: self)
    }

}

extension InventoryViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    //  MARK: - Table View Funtion
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? InventoryCell else {
            return UITableViewCell()
        }
        
        cell.ingredientName.text = currentCells[indexPath.row].name
        cell.ingredientCategory.text = currentCells[indexPath.row].category.rawValue
        cell.ingredientImage.image = currentCells[indexPath.row].image
        return cell
    }
    
    //MARK: - Swipe Delete Action
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let ingredient = currentCells[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            entireCells.remove(at: indexPath.row)
            
            
            completion(true)
        }
        
        return action
    }
    
    
    
    
    // MARK: - SearchBar Functionality
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)
        
        let containsString: (Ingredient, String) -> Bool = { (ingredient, searchText) in
            ingredient.name.lowercased().contains(searchText.lowercased()) || ingredient.category.rawValue.lowercased().contains(searchText.lowercased())
        }
        
        currentCells = !searchText.isEmpty ? entireCells.filter { containsString($0, searchText) } : entireCells
        inventoryTable.reloadData()
    }
    
}


