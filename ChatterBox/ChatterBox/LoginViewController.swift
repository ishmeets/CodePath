//
//  ViewController.swift
//  ChatterBox
//
//  Created by Ishmeet Singh on 10/16/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(emailTextField.text, password:passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                println("\(user)")
                self.performSegueWithIdentifier("SignInSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
                println("Error!")
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        var user = PFUser()
        user.username = "isingh"
        user.password = "ishmeet"
        user.email = "ishmsing@gmail.com"
        // other fields can be set just like with PFObject
        user["phone"] = "408-221-3482"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println("Successfully signed up the user")
            } else {
//                let errorString = error.userInfo["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                println("Sign up failed")
            }
        }
    }

}

