//
//  ChatViewController.swift
//  ChatterBox
//
//  Created by Ishmeet Singh on 10/16/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as MessageCell

        var query = PFQuery(className:"Message")
        query.findObjectsInBackgroundWithBlock { (messages, error) -> Void in
            if error == nil {
                
                cell.messageLabel.text = messages[indexPath.row]["text"] as? String
                println("\(messages[2])")
            } else {
                println("\(error)")
            }
        }
        /*        query.getObjectInBackgroundWithId("ZI8mLX9nsZ") {
            (message: PFObject!, error: NSError!) -> Void in
            if error == nil {
                cell.messageLabel.text = messageText
            } else {

            }
        }*/
        
        return cell;
    }

    @IBAction func onPost(sender: AnyObject) {
        var message = PFObject(className: "Message")
        message["text"] = messageTextView.text
        message["author"] = "Ishmeet Singh"
        message.saveInBackgroundWithBlock { (result, error) -> Void in
            if result == true {
                println("Message posted")
            } else {
                println("\(error)")
            }
        }
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
