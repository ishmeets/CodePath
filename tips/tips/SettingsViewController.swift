//
//  SettingsViewController.swift
//  tips
//
//  Created by Ishmeet Singh on 9/17/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipPercentageSlider: UISlider!
    @IBOutlet weak var defaultTipPercentageLabel: UILabel!
    
    var defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultTipPercentageSlider.value = Float(defaults.integerForKey("defaultTipPercentage"))
        onSliderValueChanged(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSliderValueChanged(sender: AnyObject) {
        defaultTipPercentageLabel.text = NSNumberFormatter().stringFromNumber(defaultTipPercentageSlider.value) + "%"
    }

    @IBAction func onSaveAndExitSettings(sender: AnyObject) {
        defaults.setInteger(Int(defaultTipPercentageSlider.value), forKey: "defaultTipPercentage")
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
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
