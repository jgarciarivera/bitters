//  CocktailsTVCell.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/12/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailsListCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var baseDescription: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var missingIngredientsIndicator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
