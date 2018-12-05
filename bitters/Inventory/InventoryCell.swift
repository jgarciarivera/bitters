//
//  InventoryTableViewCell.swift
//  bitters
//
//  Created by Luis Flores on 10/29/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//


//{
//    @IBInspectable var cornerRadius: CGFloat = 6.0
//    @IBInspectable var shadowColor: UIColor? = UIColor.gray
//    @IBInspectable var shadowOffsetWidth: Int = 0
//    @IBInspectable var shadowOffsetHeight: Int = 1
//    @IBInspectable var shadowOpacity: Float = 0.4
//
//    override func layoutSubviews() {
//        layer.cornerRadius = cornerRadius
//        layer.shadowColor = shadowColor?.cgColor
//        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowOpacity = shadowOpacity
//    }
//}

import UIKit
import FirebaseDatabase
import SDWebImage

class InventoryCell: UITableViewCell {

    @IBOutlet weak var ingredientImage: UIImageView! {
        didSet {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, 1.0]

            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 0, y: 0)
            gradient.frame = CGRect(x: 0,
                                    y: 0,
                                    width: UIScreen.main.bounds.width,
                                    height: ingredientImage.bounds.height)

            ingredientImage.layer.insertSublayer(gradient, at: 0)
            ingredientImage.contentMode = .scaleAspectFill
            ingredientImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredientCategory: UILabel!
    
    //Variables for Cell Appearence
    @IBInspectable var cornerRadius: CGFloat = 6.0
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.4
    
    override func layoutSubviews() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
        
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
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
