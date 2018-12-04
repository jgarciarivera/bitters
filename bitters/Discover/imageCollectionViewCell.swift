//
//  imageCollectionViewCell.swift
//  
//
//  Created by COMMStudent on 12/1/18.
//

import UIKit

class imageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var recentImage: UIImageView! {
        didSet {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, 1.0]
            
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 0, y: 0)
            gradient.frame = CGRect(x: 0,
                                    y: 0,
                                    width: UIScreen.main.bounds.width,
                                    height: recentImage.bounds.height)
            
            recentImage.layer.insertSublayer(gradient, at: 0)
            recentImage.contentMode = .scaleAspectFill
            recentImage.clipsToBounds = true
        }
    }
    
//    func populateImage(url: URL) {
//        recentImage.sd_setImage(with: url)
//    }
//
//    func populate(cocktail: Cocktail) {
//        nameLabel.text = cocktail.name
//        self.populate(url: cocktail.name)
//
//    }
    
    
}
