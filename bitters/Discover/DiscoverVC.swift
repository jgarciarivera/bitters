//
//  DiscoverVC.swift
//  bitters
//
//  Created by COMMStudent on 11/14/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit
import CoreMotion



class DiscoverVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //let items:[String] = ["0", "1", "2", "3", "4"]
    
    var shadowBlur: CGFloat = 14
    var shadowOpacity: Float = 0.6
    var shadowColor: UIColor = UIColor.gray
    var cardRadius: CGFloat = 20
    var contentInset: CGFloat = 6
    
  
    @IBOutlet weak var featuredImage: UIImageView!
 
    @IBOutlet weak var featuredView: UIView!
    @IBOutlet weak var CollectionViewRecent: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        featuredView.layer.cornerRadius = 20.0 //not working
        featuredView.layer.borderWidth = 1.0
        featuredView.layer.borderColor = UIColor.clear.cgColor
        featuredView.layer.masksToBounds = false
        featuredView.layer.shadowColor = UIColor.gray.cgColor
        featuredView.layer.shadowOffset = CGSize(width: 0, height: 0)
        featuredView.layer.shadowRadius = 12.0
        featuredView.layer.shadowOpacity = 1
        

        featuredImage.layer.cornerRadius = 20.0
        featuredImage.image = imageArrayss[0]
        featuredImage.contentMode = .scaleAspectFill
        // set the bottom part if the not set in xcode
        
        //featuredImage.layer.masksToBounds = true
        
         featuredImage.layer.shadowPath = UIBezierPath(roundedRect: featuredImage.bounds, cornerRadius: featuredImage.layer.cornerRadius).cgPath
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    var imageArrayss = [UIImage(named: "0"),UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // may have to change this

        return imageArrayss.count
    }
   
    
    //Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentImageCell", for: indexPath) as! imageCollectionViewCell
        
        cell.recentImage.image = imageArrayss[indexPath.row]
        
       
//////////////
        
//        cell.contentView.layer.cornerRadius = 15.0 //not working
//        cell.contentView.layer.borderWidth = 1.0
//        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        //cell.contentView.layer.masksToBounds = true
        
        cell.layer.borderWidth  = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.cornerRadius = 15.0
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 6.0 // test
        cell.layer.shadowOpacity = 1 // test
        cell.layer.masksToBounds = false
     
        cell.recentImage.layer.cornerRadius = 15.0
        cell.recentImage.clipsToBounds = true
        cell.recentImage.contentMode = .scaleAspectFill
        
        
        // just in case
        //cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
       
        
    
        return cell
    }
    
    internal func setHeaderHeight(_ height: CGFloat) {
        //featuredImage.constant = height
        view.layoutIfNeeded()
    }
    
    
}


