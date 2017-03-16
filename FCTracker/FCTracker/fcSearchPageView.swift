//
//  FirstViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 1/26/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class fcSearchPageView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var fcName: UITextField!
    @IBOutlet var fcAdd1: UITextField!
    @IBOutlet var fcAdd2: UITextField!
    @IBOutlet var fcAdd3: UITextField!
    @IBOutlet var fcMon: UITextField!
    @IBOutlet var fcTue: UITextField!
    @IBOutlet var fcWed: UITextField!
    @IBOutlet var fcThu: UITextField!
    @IBOutlet var fcFri: UITextField!
    @IBOutlet var fcSat: UITextField!
    @IBOutlet var fcSun: UITextField!
    @IBOutlet var fcRate: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageScrollView: UIScrollView!
    
    @IBOutlet var fcSearchView: UITextField!
    
    var items:[String] = []
    var foodCart:String = ""
    
    override func viewWillAppear(animated: Bool) {
        if globalFCSearch != "" {
            populateHome()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pageScrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+1000)
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        fcName.userInteractionEnabled = false
        fcAdd1.userInteractionEnabled = false
        fcAdd2.userInteractionEnabled = false
        fcAdd3.userInteractionEnabled = false
        fcMon.userInteractionEnabled = false
        fcTue.userInteractionEnabled = false
        fcWed.userInteractionEnabled = false
        fcThu.userInteractionEnabled = false
        fcFri.userInteractionEnabled = false
        fcSat.userInteractionEnabled = false
        fcSun.userInteractionEnabled = false
        fcRate.userInteractionEnabled = false
        
//        if globalFCSearch != "" {
//            populateHome()
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //@IBOutlet var pageScrollView: UIScrollView!
    //var items: [String] = ["We ", "Heart NSLineBreakMode.ByWordWrapping NSLineBreakMode.ByWordWrapping NSLineBreakMode.ByWordWrapping NSLineBreakMode.ByWordWrapping", "Swift"]
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let cell:CustomPostCell = self.tableView.dequeueReusableCellWithIdentifier("otherCell", forIndexPath: indexPath) as! CustomPostCell
        if items.count > 0 && indexPath.row <= items.count - 1 {
            cell.set3(fcName.text!, Post: items[indexPath.row])
        }
        else {
            cell.set3("Temp", Post: "There is no post atm")
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var returnValue = CGFloat()
        
        if (items.count > 0) {
            let stringData = items[indexPath.row] as NSString
            let constraintRect = CGSize(width: 280.0, height: CGFloat.max)
            //get height of the string used
            let boundingBox = stringData.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil)
            return boundingBox.height + CGFloat(40.0)
        }
        else{
            returnValue = CGFloat(85.0);
        }
        return returnValue;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    

    @IBAction func clickFav(sender: UIButton) {
        
        let fcname = globalFCSearch

        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcSetFav.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        //let data = "data=Hi".dataUsingEncoding(NSUTF8StringEncoding)
        let dictionary = ["UserName": globalUserName, "fcName": fcname]
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
                    //self.PrivLevel = dataString!
                    //                    dispatch_async(dispatch_get_main_queue(), {
                    //                        print(NSThread.isMainThread()) // true (we told it to execute this new block on the main queue)
                    //                        // Execute the code to update your UI (change your view) from here
                    //
                    //                        print("Temp")
                    //                    });
                    
                }
            );
            
            task.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }

    }

    
    func populateHome() {
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcSearchPopulate.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let UserName: String = globalUserName
        
        let dictionary = ["UserName": UserName, "fcName": globalFCSearch, "fSearch": globalFCSearch]
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
            let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
                {(data,response,error) in
                    
                    guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                        print("error")
                        return
                    }
                    //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
                    //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: String]
                        dispatch_async(dispatch_get_main_queue(), {
                            print(json)
                            self.fcName.text = json["fcName"]
                            //self.foodCart = json["fcName"]!
                            self.fcAdd1.text = json["fcAdd1"]
                            self.fcAdd2.text = json["fcAdd2"]
                            self.fcAdd3.text = json["fcAdd3"]
                            self.fcMon.text = json["fcMon"]
                            self.fcTue.text = json["fcTue"]
                            self.fcWed.text = json["fcWed"]
                            self.fcThu.text = json["fcThu"]
                            self.fcFri.text = json["fcFri"]
                            self.fcSat.text = json["fcSat"]
                            self.fcSun.text = json["fcSun"]
                            self.fcRate.text = json["calcRate"]
                            
                            self.populatePost()
                            //self.getRating() No longer used.
                        });
                        
                        //}
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                    //here
                }
            );
            task.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
    }
    
    func populatePost() {
        let url2:NSURL = NSURL(string: "http://www.hvz-go.com/fcPostPopulate.php")!
        let session2 = NSURLSession.sharedSession()
        //let fcname:String = globalFCSearch
        let request2 = NSMutableURLRequest(URL: url2)
        request2.HTTPMethod = "POST"
        request2.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        items = []
        let dictionary = ["UserName": globalUserName, "fcName": globalFCSearch]
        do{
            let data2 = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
            let task2 = session2.uploadTaskWithRequest(request2, fromData: data2, completionHandler:
                {(data2,response2,error) in
                    
                    guard let _:NSData = data2, let _:NSURLResponse = response2  where error == nil else {
                        print("error23")
                        return
                    }
                    //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
                    //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
                    do {
                        let response2 = try NSJSONSerialization.JSONObjectWithData(data2!, options: []) as! [String: String]
                        dispatch_async(dispatch_get_main_queue(), {
                            //print( "you are here")
                            //print(response2)
                            //print("your are past")
                            //let i:Int = 0
                            for (key, value) in response2 {
                                print("\(key) , \(value)")
                                if key != "status" {
                                    self.items.append(value)
                                }
                            }
                            
                            for (key, value) in response2 {
                                //print("\(key) , \(value)")
                                if(key != "status" && key != "message" && key != "1") {
                                    self.items[Int(key)!-1] = value
                                }
                            }
                            
                            self.tableView.reloadData()
                            
                        });
                        
                    } catch let error as NSError {
                        print("Failed to load 455: \(error.localizedDescription)")
                    }
                    
                }
            );
            task2.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
        
    }
    
    
    @IBAction func clickWriteReview(sender: UIButton) {
        //globalFCSearch = fcName.text!
        
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("writeReview") as! fcWriteReviewController
        self.presentViewController(resultViewController, animated:true, completion:nil)

    }
    
    @IBAction func clickGotoReviews(sender: UIButton) {
        //globalFCSearch = fcName.text!
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("viewReview") as! fcReviewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }

    @IBAction func clickMenu(sender: UIButton) {
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("menuViewController") as! MenuViewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func clickSearch(sender: UIButton) {
        globalFCSearch = fcSearchView.text!
        items = []
        print(globalFCSearch)
        populateHome()
    }
    
}

