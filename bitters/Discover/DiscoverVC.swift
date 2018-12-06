//  DiscoverVC.swift
//  bitters
//
//  Created by COMMStudent on 11/14/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class DiscoverVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var featuredView: UIView!
    @IBOutlet weak var CollectionViewRecent: UICollectionView!
    
    var selectedCocktail = Cocktail(dictionary: defaultCocktailDictionary)
    
    
    
    
    //Cocktail(name: "Moscow Mule")
    var imageArrayss = [UIImage(named: "0"),
                        UIImage(named: "1"),
                        UIImage(named: "2"),
                        UIImage(named: "3"),
                        UIImage(named: "4"),
                        UIImage(named: "5"),
                        UIImage(named: "6"),
                        UIImage(named: "7"),
                        UIImage(named: "8"),
                        UIImage(named: "9")]
    //var imageLabel = ["", ]
    var number = Int.random(in: 0 ... 9)
    override func viewDidLoad() {
        super.viewDidLoad()
        dbConnection = DatabaseConnection()
        setUpUserInterface()
        configureFeaturedImageTap()
    }
    
    func setUpUserInterface() {
        featuredView.layer.cornerRadius = 20.0
        featuredView.layer.borderWidth = 1.0
        featuredView.layer.borderColor = UIColor.clear.cgColor
        featuredView.layer.masksToBounds = false
        featuredView.layer.shadowColor = UIColor.black.cgColor
        featuredView.layer.shadowOffset = CGSize(width: 10, height: 10)
        featuredView.layer.shadowRadius = 6.0
        featuredView.layer.shadowOpacity = 0.75
        featuredImage.layer.cornerRadius = 20.0
        featuredImage.image = imageArrayss[4]
        featuredImage.contentMode = .scaleAspectFill
        featuredImage.layer.masksToBounds = true
    }
    
    func configureFeaturedImageTap() {
        featuredImage.isUserInteractionEnabled = true
        featuredImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onImageTapped)))
    }
    
    @objc func onImageTapped() {
        self.performSegue(withIdentifier: "discoverToCocktail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "discoverToCocktail" {
            let destinationViewController = segue.destination as! CocktailDescriptionVC
            destinationViewController.cocktail = selectedCocktail
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArrayss.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentImageCell", for: indexPath) as! imageCollectionViewCell
        number = Int.random(in: 0 ... 9)
        cell.recentImage.image = imageArrayss[number]
//        cell.contentView.layer.cornerRadius = 15.0 //not working
        cell.layer.borderWidth  = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.cornerRadius = 15.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.layer.shadowRadius = 6.0 // test
        cell.layer.shadowOpacity = 0.75 // test
        cell.layer.masksToBounds = false
        cell.recentImage.layer.cornerRadius = 15.0
        cell.recentImage.clipsToBounds = true
        cell.recentImage.contentMode = .scaleAspectFill
        cell.recentImage.isUserInteractionEnabled = true
        cell.recentImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onImageTapped)))

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}


