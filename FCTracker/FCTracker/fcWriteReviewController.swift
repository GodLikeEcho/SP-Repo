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
                        self.updateRating(fcname)
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
    
    func updateRating(foodCart:String) {
        
        //var ratings:[String] = []
        //var rate:Int = 0
        //var count = 0
        //var found = true
        let url5:NSURL = NSURL(string: "http://www.hvz-go.com/fcUpdateRating.php")!
        let session5 = NSURLSession.sharedSession()
        
        let request5 = NSMutableURLRequest(URL: url5)
        request5.HTTPMethod = "POST"
        request5.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = ["fcName": foodCart, "Rate": rating]
        
        do{
            let data5 = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
            let task5 = session5.uploadTaskWithRequest(request5, fromData: data5, completionHandler:
                {(data5,response5,error) in
                    
                    guard let _:NSData = data5, let _:NSURLResponse = response5  where error == nil else {
                        print("error43")
                        return
                    }
                    //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
                    //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
                    do {
                        let response5 = try NSJSONSerialization.JSONObjectWithData(data5!, options: []) as! [String: String]
                        dispatch_async(dispatch_get_main_queue(), {
                            //print(response3)
                            
                            for (key, value) in response5 {
                                print("\(key) , \(value)")
                                //ratings.append(value)
//                                if(value == "False")
//                                {
//                                    found = false
//                                }
                            }
//                            if found == true {
//                                for (key, value) in response5 {
//                                    //print("\(key) , \(value)")
//                                    //self.items[Int(key)!-1] = value
//                                    if key != "status" && key != "message" && key != "1" {
//                                        rate += Int(value)!
//                                        count += 1
//                                    }
//                                }
//                                if rate != 0 {
//                                    rate = rate/count
//                                    self.fRate.append(String(rate))
//                                }
                            //}
//                            else {
//                                self.fRate.append("0")//self.fcRate.text = "0"
//                            }
                            //self.tableView.reloadData()
                            
                        });
                        
                        //}
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                }
            );
            task5.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
        
        
    }

    @IBAction func clickBack(sender: UIButton) {
        if globalUserLevel == "f" {
            let storyBoard : UIStoryboard = self.storyboard!
            let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
            self.presentViewController(resultViewController, animated:true, completion:nil)
            
        }
        else {
            let storyBoard : UIStoryboard = self.storyboard!
            let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("UTab") as! UITabBarController
            self.presentViewController(resultViewController, animated:true, completion:nil)
        }

    }
 

}
