//  FavoritesViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 12/2/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit
import Firebase

class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(destinationViewController, animated: true, completion: nil)
        }
        
    }
}
