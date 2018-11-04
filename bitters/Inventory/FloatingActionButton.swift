//
//  FloatingActionButton.swift
//  
//
//  Created by Luis Flores on 11/2/18.
//

import UIKit

class FloatingActionButton: UIButton {
        
    override func draw(_ rect: CGRect) {
        let color =  UIColor(red: 182.0/255, green: 86.0/255, blue: 86.0/255, alpha: 1.0).cgColor
        layer.backgroundColor = color
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
