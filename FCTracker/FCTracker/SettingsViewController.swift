//
//  SecondViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 1/26/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickLogOut(sender: UIButton) {
        globalUserName = ""
        globalFCSearch = ""
        globalUserLevel = ""
        globalNew = false
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }

}

