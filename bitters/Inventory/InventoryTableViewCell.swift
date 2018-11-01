//
//  InventoryTableViewCell.swift
//  bitters
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InventoryTableViewCell: UITableViewCell {

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

}
