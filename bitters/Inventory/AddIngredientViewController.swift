//
//  AddIngredientViewController.swift
//  bitters
//
//  Created by Luis Flores on 10/30/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit

var chosenCategory: Ingredient.category?

class AddIngredientViewController: UIViewController {
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var ingredientName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveIngredient(_ sender: Any) {
        if let newName = ingredientName.text as String?{
            if let newCategory = chosenCategory as Ingredient.category? {
                addNewIngredient(ingredientToBeAdded: sampleIngredient)
                dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension AddIngredientViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Ingredient.category.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Ingredient.category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCategory = Ingredient.category.allCases[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
