//  CocktailIngredientsCell.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/12/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailIngredientsCell: UITableViewCell {
    
    @IBOutlet weak var ingredient: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
