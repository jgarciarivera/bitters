//
//  ShoppingListCell.swift
//  bitters
//
//  Created by Kaelaholme on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import Foundation
import UIKit

class ShoppingListCell: UITableViewCell
{
    var itemName: String?
    var itemView: UITextView =
    {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(itemView)
        itemView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        itemView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        itemView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        itemView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //itemView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        //An image next to item
        //itemView.leftAnchor.constraint(equalTo: self.itemView.rightAnchor).isActive = true
    }
    override func layoutSubviews()
    {
        super.layoutSubviews()
        if let itemName = itemName
        {
            //Custom cell check
            itemView.text = "Item:" + itemName
            //itemView.text = itemName
        }
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
