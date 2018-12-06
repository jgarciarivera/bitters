//  CocktailDescriptionViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailDescriptionVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var name: String = ""
    var cocktail: Cocktail!
    var databaseService = dbConnection

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cocktail.name
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //cocktail = databaseService.getDetailedCocktailInfo(name: name)
    }
}

extension CocktailDescriptionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let photoCell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! CocktailPhotoCell
            
            photoCell.photo.sd_setImage(with: cocktail.image)
            
            photoCell.isUserInteractionEnabled = false
            return photoCell
        } else if (indexPath.row == 1) {
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "informationCell") as! CocktailInformationCell
            
            descriptionCell.title.text = "Description"
            descriptionCell.body.text = cocktail.description

            descriptionCell.isUserInteractionEnabled = false
            return descriptionCell
        } else if (indexPath.row == 2) {
            let recipeCell = tableView.dequeueReusableCell(withIdentifier: "informationCell") as! CocktailInformationCell
            
            recipeCell.title.text = "Recipe"
            for (index, instruction) in cocktail.instructions.enumerated() {
                if !(recipeCell.body.text!.isEmpty) && (index == cocktail.instructions.startIndex) {
                    recipeCell.body.text! = "\(index + 1). \(instruction)"
                } else {
                    recipeCell.body.text! += "\n\(index + 1). \(instruction)"
                }
            }
            
            recipeCell.isUserInteractionEnabled = false
            return recipeCell
        } else {
            let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: "informationCell") as! CocktailInformationCell
            
            ingredientsCell.title.text = "Ingredients"
            
            for (index, ingredient) in cocktail.ingredients.enumerated() {
                if !(ingredientsCell.body.text!.isEmpty) && (index == cocktail.ingredients.startIndex) {
                    ingredientsCell.body.text! = "\(index + 1). \(ingredient.category.rawValue)"
                } else {
                    ingredientsCell.body.text! += "\n\(index + 1). \(ingredient.category.rawValue)"
                }
            }

            ingredientsCell.isUserInteractionEnabled = false
            return ingredientsCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}




