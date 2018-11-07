//  CocktailsViewController.swift
//  bitters
//
//  Created by Jorge Garcia-Rivera on 11/4/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.

import UIKit

class CocktailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cocktails = [Cocktail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        cocktails = updateCocktailCellContent()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = cell.viewWithTag(1) as! UILabel
        let description = cell.viewWithTag(2) as! UITextView
        let picture = cell.viewWithTag(3) as! UIImageView

        name.text = cocktails[indexPath.row].name
        description.text = cocktails[indexPath.row].description
        picture.image = cocktails[indexPath.row].image
        
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     }
}
