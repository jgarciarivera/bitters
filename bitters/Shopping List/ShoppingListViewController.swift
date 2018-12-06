//
//  ShoppingListViewController.swift
//  bitters
//
//  Created by Kaelaholme on 11/10/18.
//  Copyright © 2018 Jorge Garcia-Rivera. All rights reserved.
//

import UIKit
import MapKit
import Firebase

struct ListCellData: Codable
{
    let itemName: String
    var itemSelected: Bool
}

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate
{
    
    @IBOutlet weak var addItemButton: UIButton!
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(destinationViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func addShoppingListItemButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (shoppingListField) in shoppingListField.placeholder = "Enter Item" }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let itemEntry = alert.textFields?.first?.text else {
                return }
            self.addItem(ListCellData.init(itemName: itemEntry, itemSelected: false))
            self.saveListData()
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(action)

        present(alert, animated: true)
        self.ShoppingListView.reloadData()
    }
    
    var listData = [ListCellData]()
    var mapItem = MKMapItem()
    var coordinate = CLLocationCoordinate2D()
    
    func loadListData()
    {
        if let data = UserDefaults.standard.value(forKey: "ShoppingListData") as? Data
        {
            listData = try! PropertyListDecoder().decode(Array<ListCellData>.self, from: data)
        }
    }
    func saveListData()
    {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.listData), forKey: "ShoppingListData")
    }
    func addItem(_ item: ListCellData)
    {
        listData.append(item)
        let indexPath = IndexPath(row: listData.count - 1, section: 0)
        ShoppingListView.insertRows(at: [indexPath], with: .automatic)
    }
    @IBOutlet weak var ShoppingListView: UITableView!
    @IBOutlet weak var StoreMapView: MKMapView!
    func showLiquorStoreOnMap()
    {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "\"liquor store\""
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start
            {
                (response, error) in
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if response == nil
                {
                    print ("no search result")
                }
                else
                {
                    for mapItem in (response?.mapItems)!.reversed()
                    {
                        let annotations = self.StoreMapView.annotations
                        self.StoreMapView.removeAnnotations(annotations)
                        let latitude = mapItem.placemark.coordinate.latitude
                        let longitude = mapItem.placemark.coordinate.longitude
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate, span: span)
                        self.StoreMapView.setRegion(region, animated: true)
                        let geocoder = CLGeocoder()
                        let location = CLLocation(latitude: latitude, longitude: longitude)
                        geocoder.reverseGeocodeLocation(location, completionHandler:
                            { (placemarks, error) in
                                if (error == nil)
                                {
                                    
                                    let street = placemarks?[0].thoroughfare
                                    let streetNumber = placemarks?[0].subThoroughfare
                                    if (street != nil && streetNumber != nil)
                                    {
                                        annotation.title = streetNumber! + " " + street!
                                    }
                                    else
                                    {
                                        annotation.title = "Nearby Liquor Store"
                                    }
                                    self.StoreMapView.addAnnotation(annotation)
                                }
                        })
                    }
                }
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        let regionSpan = MKCoordinateRegion(center: (view.annotation?.coordinate)!, latitudinalMeters: 10, longitudinalMeters: 10)
        let options =
            [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
                MKLaunchOptionsShowsTrafficKey: true,
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault
            ] as [String : Any]
        let placemark = MKPlacemark(coordinate: (view.annotation?.coordinate)!)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.openInMaps(launchOptions: options)
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
        if (listData[indexPath.row].itemSelected)
        {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
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
        saveListData()
    }
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete else { return }
        listData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveListData()
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
        StoreMapView.delegate = self
        ShoppingListView.dataSource = self
        ShoppingListView.delegate = self
        ShoppingListView.register(ShoppingListCell.self, forCellReuseIdentifier: "itemCell")
        loadListData()
        stylizeAddShoppingItemButton()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool)
    {
        showLiquorStoreOnMap()
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
     */
    
    /*
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
    
    func stylizeAddShoppingItemButton() {
        addItemButton.layer.cornerRadius = addItemButton.frame.height/2
        addItemButton.layer.shadowOpacity = 0.3
        addItemButton.layer.shadowRadius = 4
        addItemButton.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
}
