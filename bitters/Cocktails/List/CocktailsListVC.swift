//  CocktailsViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/4/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cocktails = [Cocktail]()
    var selectedCocktail = Cocktail()
    var dbDelegate = DatabaseConnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        cocktails = dbDelegate.getUserCocktails()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listToDescription") {
            let destination = segue.destination as! CocktailDescriptionVC
            destination.name = selectedCocktail.name
        }
    }
}

extension CocktailsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailsListCell") as? CocktailsListCell else {
            return UITableViewCell()
        }
        
        cell.name.text = cocktails[indexPath.row].name
        cell.baseDescription.text = cocktails[indexPath.row].description
        cell.icon.image = cocktails[indexPath.row].image
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCocktail = cocktails[indexPath.row]
        performSegue(withIdentifier: "listToDescription", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
