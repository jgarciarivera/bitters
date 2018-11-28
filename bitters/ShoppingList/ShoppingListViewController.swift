//
//  ShoppingListViewController.swift
//  bitters
//
//  Created by Kaelaholme on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit

struct ListCellData
{
    let itemName: String?
    var itemSelected: Bool
}

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var listData = [ListCellData]()
    @IBAction func clickEdit(_ sender: Any)
    {
        print("edit")
    }
    @IBAction func clickAdd(_ sender: Any)
    {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (shoppingListField) in shoppingListField.placeholder = "Enter Item" }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let itemEntry = alert.textFields?.first?.text else { return }
            print (itemEntry)
            self.addItem(ListCellData.init(itemName: itemEntry, itemSelected: false))
        }
        alert.addAction(action)
        present(alert, animated: true)
        self.ShoppingListView.reloadData()
    }
    func addItem(_ item: ListCellData)
    {
        let index = 0
        listData.insert(item, at: index)
        let indexPath = IndexPath(row: index, section: 0)
        ShoppingListView.insertRows(at: [indexPath], with: .automatic)
        //self.ShoppingListView.reloadData()
    }
    @IBOutlet weak var ShoppingListView: UITableView!
    func getShoppingListData()
    {
        //Placeholder Data
        listData.append(ListCellData.init(itemName: "Ice", itemSelected: false))
        listData.append(ListCellData.init(itemName: "Water", itemSelected: false))
        listData.append(ListCellData.init(itemName: "Whiskey", itemSelected: false))
        //self.tableView.register(ShoppingListCell.self, forCellReuseIdentifier: "listCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "itemCell")
        //let cell = ShoppingListCell()
        cell.textLabel?.text = listData[indexPath.row].itemName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = listData[indexPath.row]
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "itemCell")
        if (item.itemSelected)
        {
            listData[indexPath.row].itemSelected = false
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        else
        {
            listData[indexPath.row].itemSelected = true
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows
        {
            for indexPath in selectedIndexPaths
            {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete else { return }
        listData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        if let index = self.ShoppingListView.indexPathForSelectedRow
        {
            self.ShoppingListView.deselectRow(at: index, animated: true)
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        getShoppingListData()
        ShoppingListView.register(ShoppingListCell.self, forCellReuseIdentifier: "itemCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
     */

    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print  ("count:", listData.count)
        return listData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ShoppingListCell
        cell.itemName = listData[indexPath.row].itemName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}