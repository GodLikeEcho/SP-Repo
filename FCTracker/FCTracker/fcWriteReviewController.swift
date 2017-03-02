//
//  fcWriteReviewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/2/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class fcWriteReviewController: UIViewController {
    
    var review:String = ""
    var rating:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rating = "1"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var reviewText: UITextView!
    @IBOutlet var segStars: UISegmentedControl!
    
    @IBAction func clickStars(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            rating = "1"
        case 1:
            rating = "2"
        case 2:
            rating = "3"
        case 3:
            rating = "4"
        case 4:
            rating = "5"
        default:
            break
        }

    }
    @IBAction func clickSubmit(sender: UIButton) {
        
        let UserName: String = globalUserName
        let fcname: String = globalFCSearch
        let post: String = reviewText.text!
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcWriteReview.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = [ "UserName": UserName, "fcName": fcname, "Post": post, "Rate": rating ]
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
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        //self.tableView.reloadData()
                        //self.tableView.reloadData()
                        print("Submit")
                        
                        let storyBoard : UIStoryboard = self.storyboard!
                        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
                        self.presentViewController(resultViewController, animated:true, completion:nil)
                        
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

}
