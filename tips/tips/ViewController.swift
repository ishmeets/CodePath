//
//  ViewController.swift
//  tips
//
//  Created by Ishmeet Singh on 9/17/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var codepathLabel: UILabel!
    @IBOutlet weak var billTextLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var blackLineView: UIView!
    @IBOutlet weak var totalTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onEditingChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingBegin(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: {
            self.codepathLabel.frame.size.height = 0
            self.codepathLabel.frame.origin.y = 0
            self.billField.frame.origin.y = 95
            self.billTextLabel.frame.origin.y = 106
            self.tipLabel.frame.origin.y = 150
            self.tipTextLabel.frame.origin.y = 150
            self.blackLineView.frame.origin.y = 200
            self.totalTextLabel.frame.origin.y = 230
            self.totalLabel.frame.origin.y = 230
            self.tipControl.frame.origin.y = 290
        })
    }


    @IBAction func onEditingEnd(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: {
            self.codepathLabel.frame.size.height = 33
            self.codepathLabel.frame.origin.y = 105
            self.billField.frame.origin.y = 176
            self.billTextLabel.frame.origin.y = 185
            self.tipLabel.frame.origin.y = 273
            self.tipTextLabel.frame.origin.y = 273
            self.blackLineView.frame.origin.y = 318
            self.totalTextLabel.frame.origin.y = 361
            self.totalLabel.frame.origin.y = 361
            self.tipControl.frame.origin.y = 443
        })
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTipPercentage = 20
        
        billField.clearsOnBeginEditing = true
        if defaults.integerForKey("defaultTipPercentage") != 0 {
            defaultTipPercentage = defaults.integerForKey("defaultTipPercentage")
        } else {
            defaults.setInteger(20, forKey: "defaultTipPercentage")
            defaults.synchronize()
        }
        
        tipControl.setTitle("\(defaultTipPercentage - 2)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(defaultTipPercentage)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(defaultTipPercentage + 2)%", forSegmentAtIndex: 2)
        
        
        var tipPercentages = [defaultTipPercentage - 2, defaultTipPercentage, defaultTipPercentage + 2]
        var tipPercentage = Double(tipPercentages[tipControl.selectedSegmentIndex])
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage / 100
        var total = billAmount + tip

        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        onEditingChanged(self)
    }
}

