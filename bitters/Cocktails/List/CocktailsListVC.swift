//  CocktailsViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/4/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailsListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dbDelegate = DatabaseConnection()
    var selectedSegment = 0
    var allCocktails = globalCocktails
    var availableCocktails = globalCocktails
    var selectedCocktail: Cocktail?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        allCocktails = dbDelegate.getAllCocktails()
        availableCocktails = dbDelegate.getAvailableCocktails()
    }
    
    @IBAction func toggleSegment(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            selectedSegment = 0
        } else {
            selectedSegment = 1
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "listToDescription") {
            let destinationViewController = segue.destination as! CocktailDescriptionVC
            destinationViewController.cocktail = selectedCocktail
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension CocktailsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allCocktailsCell = tableView.dequeueReusableCell(withIdentifier: "cocktailsListCell") as! CocktailsListCell
        let availableCocktailsCell = tableView.dequeueReusableCell(withIdentifier: "availableCocktailsListCell") as! CocktailsListCell
        
        if (selectedSegment == 0) {
            allCocktailsCell.name.text = allCocktails[indexPath.row].name
            allCocktailsCell.baseDescription.text = allCocktails[indexPath.row].description
            allCocktailsCell.icon.sd_setImage(with: allCocktails[indexPath.row].image)
            allCocktailsCell.contentView.backgroundColor = UIColor(white: 1, alpha: 1)
            return allCocktailsCell
        } else {
            availableCocktailsCell.name.text = availableCocktails[indexPath.row].name
            availableCocktailsCell.baseDescription.text = availableCocktails[indexPath.row].description
            availableCocktailsCell.icon.sd_setImage(with: availableCocktails[indexPath.row].image)
            if (indexPath.row < 3) {
                availableCocktailsCell.missingIngredientsIndicator.image = UIImage(named: "Icon Check")!
            } else {
                availableCocktailsCell.missingIngredientsIndicator.image = UIImage(named: "Icon One")!
            }
            availableCocktailsCell.contentView.backgroundColor = UIColor(white: 1, alpha: 1)
            return availableCocktailsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (selectedSegment == 0) {
            selectedCocktail = allCocktails[indexPath.row]
        } else {
            selectedCocktail = availableCocktails[indexPath.row]
        }
        performSegue(withIdentifier: "listToDescription", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selectedSegment == 0) {
            return allCocktails.count
        } else {
            return availableCocktails.count
        }
    }
}

// MARK : - Database Implementation

extension CocktailsListVC {
    
//    var selectedSegment = 0
//    var allCocktails = [Cocktail]()
//    var availableCocktails = [Cocktail]()
//    var selectedCocktail = Cocktail()
    
}
