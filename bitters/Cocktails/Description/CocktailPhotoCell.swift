//  CocktailPhotoCell.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 12/3/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailPhotoCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
