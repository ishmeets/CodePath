//
//  TweetsViewController.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/11/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var hud = MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
        hud.labelText = "Loading..."
        
        NwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            
            MBProgressHUD.hideAllHUDsForView(self.tableView, animated: true)

            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        if tweets != nil {
            cell.nameLabel.text = tweets?[indexPath.row].user?.name
            var screenName = tweets?[indexPath.row].user?.screenName
            cell.handleLabel.text = "@" + screenName!
            cell.tweetLabel.text = tweets?[indexPath.row].text
            var profileImageURL = tweets?[indexPath.row].user?.profileImageURL
            cell.userImageView.setImageWithURL(NSURL(string: profileImageURL!))
        }
        return cell
    }

    @IBAction func onSignOut(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
