//
//  CollectionViewCell.swift
//  bitters
//
//  Created by COMMStudent on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{

    @IBOutlet weak var label: UILabel!
    
    func displayContent(text: String) {
        label.text = text
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
