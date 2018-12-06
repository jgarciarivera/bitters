//
//  InventoryTableViewCell.swift
//  bitters
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class InventoryCell: UITableViewCell {

    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populateImage(url: URL) {
        ingredientImage.sd_setImage(with: url)
    }
    
    func populate(ingredient: Ingredient) {
        ingredientName.text = ingredient.name
        ingredientCategory.text = ingredient.category.rawValue
        
        let image = ingredient.image
        ingredientImage.sd_setImage(with: image)
    }
    
    override func prepareForReuse() {
        ingredientImage.sd_cancelCurrentImageLoad()
    }

}
