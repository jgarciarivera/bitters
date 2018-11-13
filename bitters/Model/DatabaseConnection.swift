//
//  DatabaseConnection.swift
//  bitters
//
//  Created by Luis Flores on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import Foundation
import UIKit

protocol dbConnectionDelegate {
    func getUserIngredients() -> [Ingredient]
    func getUserCocktails() -> [Cocktail]
}

class DatabaseConnection: dbConnectionDelegate  {
    
    //MARK: - Mock Cocktail Data Array
    
    
    func getUserCocktails() -> [Cocktail] {
        var cocktailArray: [Cocktail] = []
        cocktailArray.append(Cocktail(name: "Dark n Stormy"))
        cocktailArray.append(Cocktail(name: "Negroni"))
        cocktailArray.append(Cocktail(name: "Vodka Sour"))
        cocktailArray.append(Cocktail(name: "Sake Bomb"))
        cocktailArray.append(Cocktail(name: "Gibson"))
        cocktailArray.append(Cocktail(name: "Gin and Tonic"))
        cocktailArray.append(Cocktail(name: "Gin Sour"))
        cocktailArray.append(Cocktail(name: "Cojito"))
        cocktailArray.append(Cocktail(name: "Mojito"))
        
        return cocktailArray
    }
    
    
    // MARK: - Mock Ingredient Data Array
    
    func getUserIngredients() -> [Ingredient] { //This will later be used to pull data info
        
        var cellContents: [Ingredient] = []
        cellContents.append(Ingredient(name: "New Amsterdam", category: Ingredient.category.Vodka))
        cellContents.append(Ingredient(name: "Pepitos's Añejo", category: Ingredient.category.Tequila))
        cellContents.append(Ingredient(name: "Grey Goose", category: .Vodka))
        cellContents.append(Ingredient(name: "Tanqueray", category: .Gin))
        cellContents.append(Ingredient(name: "Malibu", category: .Rum))
        cellContents.append(Ingredient(name: "Crown Royal", category: .Whiskey))
        cellContents.append(Ingredient(name: "Jose Cuervo", category: .Tequila))
        cellContents.append(Ingredient(name: "Johnnie Walker", category: .Whiskey))
        cellContents.append(Ingredient(name: "Hennessy", category: .Cognac))
        cellContents.append(Ingredient(name: "Casadores", category: .Tequila))
        
        return cellContents
    }
    
    func getDetailedCocktailInfo(name: String) -> Cocktail {
        
        return Cocktail(name: name,
                        about:defaultMediumText,
                        description: defaultLongText,
                        instructions: defaultInstructions,
                        ingredients: defaultIngredients,
                        image: UIImage(named: "defaultCocktailPhoto")!)
    }
}
