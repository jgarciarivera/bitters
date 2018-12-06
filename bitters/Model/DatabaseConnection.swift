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
    func getAllCocktails() -> [Cocktail]
}

class DatabaseConnection: dbConnectionDelegate  {
    
    //MARK: - Mock Cocktail Data Array
    
    
    func getAllCocktails() -> [Cocktail] {
        var cocktailArray: [Cocktail] = []
//        cocktailArray.append(Cocktail(name: "Dark n Stormy"))
//        cocktailArray.append(Cocktail(name: "Negroni"))
//        cocktailArray.append(Cocktail(name: "Vodka Sour"))
//        cocktailArray.append(Cocktail(name: "Sake Bomb"))
//        cocktailArray.append(Cocktail(name: "Gibson"))
//        cocktailArray.append(Cocktail(name: "Gin and Tonic"))
//        cocktailArray.append(Cocktail(name: "Gin Sour"))
//        cocktailArray.append(Cocktail(name: "Cojito"))
//        cocktailArray.append(Cocktail(name: "Mojito"))
        
        return globalCocktails
    }
    
    
    // MARK: - Mock Ingredient Data Array
    
    func getUserIngredients() -> [Ingredient] { //This will later be used to pull data info
        
        var cellContents: [Ingredient] = []
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        cellContents.append(sampleIngredient)
        
        // Old sample data
//        cellContents.append(Ingredient(name: "Pepitos's Añejo", category: Ingredient.category.Tequila))
//        cellContents.append(Ingredient(name: "Grey Goose", category: .Vodka))
//        cellContents.append(Ingredient(name: "Tanqueray", category: .Gin))
//        cellContents.append(Ingredient(name: "Malibu", category: .Rum))
//        cellContents.append(Ingredient(name: "Crown Royal", category: .Whiskey))
//        cellContents.append(Ingredient(name: "Jose Cuervo", category: .Tequila))
//        cellContents.append(Ingredient(name: "Johnnie Walker", category: .Whiskey))
//        cellContents.append(Ingredient(name: "Hennessy", category: .Cognac))
//        cellContents.append(Ingredient(name: "Casadores", category: .Tequila))
        
        return cellContents
    }
    
    func getDetailedCocktailInfo(name: String) -> Cocktail {
        
        return Cocktail(name: name,
                        about:defaultMediumText,
                        description: defaultLongText,
                        instructions: defaultInstructions,
                        ingredients: defaultIngredients,
                        image: URL(string: "https://1570308986.rsc.cdn77.org/wp-content/uploads/2016/12/DSC_1447.jpg")!)
    }
    
    func getAvailableCocktails() -> [Cocktail] {
        var availableCocktails: [Cocktail] = []
//        availableCocktails.append(Cocktail(name: "Old Fashioned"))
//        availableCocktails.append(Cocktail(name: "Mexican Coffee"))
//        availableCocktails.append(Cocktail(name: "Negroni"))
//        availableCocktails.append(Cocktail(name: "Whiskey Sour"))
//        availableCocktails.append(Cocktail(name: "Manhattan"))
        return globalCocktails
    }
}
