//  CardView.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/7/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 6.0
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.6
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
}
