//
//  ContainerViewController.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/18/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

enum SlideOutState {
    case Collapsed
    case LeftPanelExpanded
}

class ContainerViewController: UIViewController, MainViewControllerDelegate {
    
    var mainNavigationController: UINavigationController!
    var mainViewController: MainViewController!
    var currentState: SlideOutState = .Collapsed
    var leftPanelViewController: LeftPanelViewController?
    let mainPanelExpandedOffset: CGFloat = 60

    override init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainViewController = UIStoryboard.mainViewController()
        mainViewController.delegate = self
        
        mainNavigationController = UINavigationController(rootViewController: mainViewController)
        view.addSubview(mainNavigationController.view)
        addChildViewController(mainNavigationController)
        
        mainNavigationController.didMoveToParentViewController(self)
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

    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
        println("toggleLeftPanel")
    }
    
    func animateLeftPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateMainPanelXPosition(targetPosition: CGRectGetWidth(mainNavigationController.view.frame) - mainPanelExpandedOffset)
        } else {
            animateMainPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .Collapsed
                
                self.leftPanelViewController!.view.removeFromSuperview()
                self.leftPanelViewController = nil;
            }
        }
    }
    
    func addLeftPanelViewController() {
        if (leftPanelViewController == nil) {
            leftPanelViewController = UIStoryboard.leftPanelViewController()
            
            view.insertSubview(leftPanelViewController!.view, atIndex: 0)
            
            addChildViewController(leftPanelViewController!)
            leftPanelViewController!.didMoveToParentViewController(self)
        }
    }
    
    func animateMainPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.mainNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
        println("animateCenterPanelXPosition")
    }
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftPanelViewController() -> LeftPanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("LeftPanelViewController") as? LeftPanelViewController
    }
    
    class func mainViewController() -> MainViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MainViewController") as? MainViewController
    }
}
