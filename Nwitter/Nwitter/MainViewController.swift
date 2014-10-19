//
//  MainViewController.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/18/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

@objc
protocol MainViewControllerDelegate {
    optional func toggleLeftPanel()
}

class MainViewController: UIViewController {
    
    var delegate: MainViewControllerDelegate?
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    @IBOutlet weak var mainNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mainNavigationItem.leftBarButtonItem = menuBarButton
        self.mainNavigationItem.rightBarButtonItem = nil
        self.mainNavigationItem.backBarButtonItem = nil
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

    @IBAction func onMenu(sender: AnyObject) {
        if let d = delegate {
            d.toggleLeftPanel?()
        }
    }
}
