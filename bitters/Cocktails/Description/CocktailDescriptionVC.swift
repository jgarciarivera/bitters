//  CocktailDescriptionViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailDescriptionVC: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullDescription: UILabel!
    @IBOutlet weak var recipe: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    var name: String = ""
    var cocktail = Cocktail()
    var databaseService = DatabaseConnection()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        cocktail = databaseService.getDetailedCocktailInfo(name: name)
        setCocktailInformation(cocktail: cocktail)
    }
    
    func setCocktailInformation(cocktail: Cocktail) {
        photo.image = cocktail.image
        fullDescription.text = cocktail.description
        
        for (index, instruction) in cocktail.instructions.enumerated() {
            if !(recipe.text!.isEmpty) && (index == cocktail.instructions.startIndex) {
                recipe.text! = "\(index + 1). \(instruction)"
            } else {
                recipe.text! += "\n\(index + 1). \(instruction)"
            }
        }
        
        for (index, ingredient) in cocktail.ingredients.enumerated() {
            if !(ingredients.text!.isEmpty) && (index == cocktail.ingredients.startIndex) {
                ingredients.text! = "\(index + 1). \(ingredient.category.rawValue)"
            } else {
                ingredients.text! += "\n\(index + 1). \(ingredient.category.rawValue)"
            }
        }
    }
}


