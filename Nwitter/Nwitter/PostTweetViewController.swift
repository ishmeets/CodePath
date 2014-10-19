//
//  PostTweetViewController.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/11/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tweetTextView.layer.borderColor = UIColor.grayColor().CGColor
        tweetTextView.layer.borderWidth = 1.0
        tweetTextView.layer.cornerRadius = 8
        
        var user = User.currentUser!
        userImageView.setImageWithURL(NSURL(string: user.profileImageURL))
        nameLabel!.text = user.name
        handleLabel!.text = "@" + user.screenName!
        tweetTextView.delegate = self
        textCountLabel.text = "140"
    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var textLimit = 140 - countElements(tweetTextView.text) - countElements(text) + range.length
        textCountLabel.text = "\(textLimit)"
        if textLimit > 0 {
            return true
        } else {
            return false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostTweet(sender: AnyObject) {
        var params = ["status": tweetTextView.text]
        NwitterClient.sharedInstance.postTweet(params, completion: { (tweet, error) -> () in
            println("Posted Tweeted: \(tweet)")
        })
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
