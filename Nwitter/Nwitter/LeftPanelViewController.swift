//
//  LeftPanelViewController.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/18/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class LeftPanelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onProfile(sender: AnyObject) {
        performSegueWithIdentifier("MainToProfileSegue", sender: self)
    }

    @IBAction func onTweets(sender: AnyObject) {
        performSegueWithIdentifier("MainToTweetsSegue", sender: self)
    }
    
    
    @IBAction func onPostATweet(sender: AnyObject) {
        performSegueWithIdentifier("MainToPostTweetSegue", sender: self)
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
