//  CocktailsViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/4/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

var cocktailCount: [(Cocktail, Int)]!

class CocktailsListVC: UIViewController {
    var dbDelegate: dbConnectionDelegate!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var segmentHeight: NSLayoutConstraint!
    
    
    var selectedSegment = 0
    var allCocktails: [Cocktail] = []
    var availableCocktails: [Cocktail] = []
    var selectedCocktail: Cocktail?
    
    let screenHeight = UIScreen.main.bounds.height
    var scrollViewContentHeight = 1400 as CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        scrollView.delegate = self
        scrollView.bounces = false
        tableView.bounces = false
        tableView.isScrollEnabled = false
        dbDelegate = dbConnection!
        allCocktails = dbDelegate.getAllCocktails()
        availableCocktails = dbDelegate.getAvailableCocktails()
        
        calculateCocktailCount()
        cocktailCount.forEach { (tuple) in
            let cocktail = tuple.0
            let count = tuple.1
            print("\n-----------------------------------\n\n Actuall Data type: \n\(tuple)\n\n :end\n")
            print("Cocktail: \(cocktail.name) Missing: \(count)\n")
        }
        tableView.reloadData()
    }
    
    func calculateCocktailCount() {
        let cocktails = globalCocktails
        let userIventory = globalUserIngredients
        
        cocktailCount = cocktails.map { (cocktail) -> (Cocktail, Int) in
            let intersectionCount: Int = missingCount(userBar: userIventory, cocktail: cocktail)
            return (cocktail, intersectionCount)
        }
        
    }
    
    func missingCount(userBar: [Ingredient], cocktail: Cocktail) -> Int {
        
        let userBarCategories: [Ingredient.category] = userBar.map { (ingredient) -> Ingredient.category in
            return ingredient.category
        }
        
        let cocktailIngredientsCategories: [Ingredient.category] = cocktail.ingredients.map { (ingredient) -> Ingredient.category in
            return ingredient.category
        }
        
        let usrCategorySet = Set(userBarCategories)
        let cocktailIngredientCategoriesSet = Set(cocktailIngredientsCategories)
        
        let intersection = usrCategorySet.intersection(cocktailIngredientCategoriesSet)
        
        print("\n\n\nIntersection:")
        intersection.forEach { (ingredient) in
            print("Ingredient Name: \(ingredient)")
        }
        
        print("\(intersection)")
        
        
        return cocktailIngredientCategoriesSet.count - intersection.count
        
        
        // Old
    //        let usrBar = Set(userBar)
    //        let cocktailIngredients = Set(cocktail.ingredients)
    //
    //        let intersection = cocktailIngredients.intersection(usrBar)
    //
    //        print("\n\n\nIntersection:")
    //        intersection.forEach { (ingredient) in
    //            print("Ingredient Name: \(ingredient.name)")
    //        }
    //        print("\(intersection)")
    //
    //        return cocktailIngredients.count - intersection.count
    }
    
    @IBAction func toggleSegment(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            selectedSegment = 0
            
            // All cocktails
        } else {
            selectedSegment = 1
            
            // Cocktails that can be made
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
            availableCocktailsCell.name.text = cocktailCount[indexPath.row].0.name
            availableCocktailsCell.baseDescription.text = cocktailCount[indexPath.row].0.description
            availableCocktailsCell.icon.sd_setImage(with: cocktailCount[indexPath.row].0.image)
            
            if (cocktailCount[indexPath.row].1 == 0) {
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.viewHeight.constant = self.tableView.contentSize.height + self.segmentHeight.constant + self.imageHeight.constant + 50
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        if scrollView == self.scrollView {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                tableView.isScrollEnabled = true
            }
        }
        
        if scrollView == self.tableView {
            if yOffset <= 0 {
                self.scrollView.isScrollEnabled = true
                self.tableView.isScrollEnabled = false
            }
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
