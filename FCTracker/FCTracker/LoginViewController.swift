//
//  LoginViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 1/26/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

//import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //@IBOutlet weak var username: UILabel!
    //@IBOutlet weak var password: UILabel!
    //@IBOutlet var username: UITextField!
    //@IBOutlet weak var username: UITextField!
    //@IBOutlet weak var password: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    var PrivLevel: NSString = "x"
    
    @IBAction func clickLogin(sender: AnyObject) {
        let UserName: String
        let Password: String
        
        UserName = username.text!
        Password = password.text!
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcLogin.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        //let data = "data=Hi".dataUsingEncoding(NSUTF8StringEncoding)
        let dictionary = ["UserName": UserName, "Password": Password]
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            //let json = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
                {(data,response,error) in
                    
                    guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                        print("error")
                        return
                    }
                    
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(dataString)
                    self.PrivLevel = dataString!
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        print(NSThread.isMainThread()) // true (we told it to execute this new block on the main queue)
                        // Execute the code to update your UI (change your view) from here
                        
                        if(self.PrivLevel == "\"u\"")
                        {
                            let storyBoard : UIStoryboard = self.storyboard!
                            let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("UTab") as! UITabBarController
                            self.presentViewController(resultViewController, animated:true, completion:nil)
                            
                        }
                        else if(self.PrivLevel == "\"f\"")
                        {
                            let storyBoard : UIStoryboard = self.storyboard!
                            let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
                            self.presentViewController(resultViewController, animated:true, completion:nil)
                            
                        }
                        else if (self.PrivLevel == "\"a\"")
                        {
                            let storyBoard : UIStoryboard = self.storyboard!
                            let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("CreatAccountVC") as! CreateAccountViewController
                            self.presentViewController(resultViewController, animated:true, completion:nil)
                        }
                        else
                        {
                            print("Hit last else")
                            print(self.PrivLevel)
                            print(self.PrivLevel == "u")
                        }
                        
                    });

                }
            );
    
            task.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
        
    }

    @IBAction func clickCreateAccount(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("CreatAccountVC") as! CreateAccountViewController
        
        self.presentViewController(resultViewController, animated:true, completion:nil)

    }
    
    
}


