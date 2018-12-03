//
//  DiscoverVC.swift
//  bitters
//
//  Created by COMMStudent on 11/14/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //let items:[String] = ["0", "1", "2", "3", "4"]
    
    @IBOutlet weak var featuredImage: UIImageView!
    
    private weak var shadowView: UIView?
    
    var imageArrayss = [UIImage(named: "0"),UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // may have to change this

        return imageArrayss.count
    }
   
    
    //Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentImageCell", for: indexPath) as! imageCollectionViewCell

    
        cell.recentImage.image = imageArrayss[indexPath.row]
        
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
  
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowColor = UIColor.black.cgColor
        
        
        cell.layer.shadowOpacity = 0.35
      
        return cell
    }
    
    //ui
    internal func setHeaderHeight(_ height: CGFloat) {
        //featuredImage.constant = height
        view.layoutIfNeeded()
    }
    
    internal func configureRoundedCorners(shouldRound: Bool) {
        featuredImage.layer.cornerRadius = shouldRound ? 14.0 : 0.0
    }
    
    //ui end
    
    // testing
 
    
   
}

