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
    var defaults = NSUserDefaults.standardUserDefaults()
    var defaultTipPercentage = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        onEditingChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [defaultTipPercentage - 5, defaultTipPercentage, defaultTipPercentage + 5]
        var tipPercentage = Double(tipPercentages[tipControl.selectedSegmentIndex])
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage / 100
        var total = billAmount + tip
        
        billField.clearsOnBeginEditing = true
        defaultTipPercentage = defaults.integerForKey("defaultTipPercentage")
        tipControl.setTitle("\(defaultTipPercentage - 5)", forSegmentAtIndex: 0)
        tipControl.setTitle("\(defaultTipPercentage)", forSegmentAtIndex: 1)
        tipControl.setTitle("\(defaultTipPercentage + 5)", forSegmentAtIndex: 2)
        
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

