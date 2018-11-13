//  CocktailDescriptionViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailDescriptionVC: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullDescription: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    var name: String = ""
    var cocktail = Cocktail()
    var databaseService = DatabaseConnection()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
    
        cocktail = databaseService.getDetailedCocktailInfo(name: name)
        fullDescription.text = cocktail.description
        photo.image = cocktail.image
        
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
}

extension CocktailDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (tableView) {
        case recipeTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailRecipeCell") as? CocktailRecipeCell
                else { return UITableViewCell() }
            cell.step.text = "\(indexPath.row + 1). \(cocktail.instructions[indexPath.row])"
            return cell
        case ingredientsTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailIngredientCell") as? CocktailIngredientsCell
                else { return UITableViewCell() }
            cell.ingredient.text = "\(indexPath.row + 1). \(cocktail.ingredients[indexPath.row].category.rawValue)" 
            return cell
        default:
            print("Table View not found")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (tableView) {
        case recipeTableView:
            return cocktail.instructions.count
        case ingredientsTableView:
            return cocktail.ingredients.count
        default:
            return 1
        }
    }
}
