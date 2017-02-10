//
//  CreateAccountViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 2/8/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

//import Foundation
import UIKit

class CreateAccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    @IBOutlet var segCon: UISegmentedControl!
    var PrivLevel: String = "u"
    
    @IBAction func clickSubmit(sender: UIButton) {
        let UserName: String
        let Password: String
        let Email: String
        
        
        UserName = username.text!
        Password = password.text!
        Email = email.text!
        //PrivLevel = "u"
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcCreateAccount.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = ["UserName": UserName, "Password": Password, "Email": Email, "PrivLevel": PrivLevel]
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            
            let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
                {(data,response,error) in
                    
                    guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                        print("error")
                        return
                    }
                    
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(dataString)
                }
            );
            task.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }

    }

    @IBAction func clickSecCon(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            PrivLevel = "u"
        case 1:
            PrivLevel = "f"
        default:
            break
        }
    }
}