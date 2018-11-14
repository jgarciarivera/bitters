//
//  DiscoverVC.swift
//  bitters
//
//  Created by COMMStudent on 11/14/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let items:[String] = ["0", "1", "2", "3", "4"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    //Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCell", for: indexPath) as! CollectionViewCell
        cell.recentImageView.image = UIImage(named: items[indexPath.row] + ".png")
        return cell
    }
}
