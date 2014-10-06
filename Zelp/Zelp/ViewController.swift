//
//  ViewController.swift
//  Zelp
//
//  Created by Ishmeet Singh on 10/3/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var restaurantList: [ZelpModel.Restaurant]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        var hud = MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
        hud.labelText = "Loading..."
        
        ZelpModel().getRestaurantList("Thai", done: { (restaurants, error) -> Void in
            MBProgressHUD.hideAllHUDsForView(self.tableView, animated: true)
        
            self.restaurantList = restaurants as [ZelpModel.Restaurant]
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (restaurantList != nil) {
            return restaurantList!.count;
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as RestaurantCell
        if let restaurant = restaurantList?[indexPath.row] {
            cell.restaurantImage.setImageWithURL(NSURL(string: restaurant.imageURL))
            cell.nameLabel.text = restaurant.name
            cell.ratingImage.setImageWithURL(NSURL(string: restaurant.ratingImageURL))
            cell.reviewsLabel.text = "\(restaurant.reviewCount) reviews"
            cell.addressLabel.text = "\(restaurant.streetAddress), \(restaurant.city) \(restaurant.state) \(restaurant.zipcode)"
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }

}

