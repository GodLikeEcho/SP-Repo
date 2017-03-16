//
//  FirstViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 1/26/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class FCHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items:[String] = []
    var foodCart:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pageScrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+1000)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        
        if globalNew == false {
            populateHome()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
    @IBOutlet var fcEdit: UIButton!
    @IBOutlet var fcSubmit: UIButton!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var postField: UITextField!
    @IBOutlet var pfSubmit: UIButton!
 
    @IBOutlet var pageScrollView: UIScrollView!
    //var items: [String] = ["We ", "Heart NSLineBreakMode.ByWordWrapping NSLineBreakMode.ByWordWrapping NSLineBreakMode.ByWordWrapping NSLineBreakMode.ByWordWrapping", "Swift"]
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let cell:CustomPostCell = self.tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! CustomPostCell
        if items.count > 0 && indexPath.row <= items.count - 1 {
            cell.set(fcName.text!, Post: items[indexPath.row])
        }
        else {
            cell.set("Temp", Post: "There is no post atm")
        }
        
        return cell
//        //let item = items[indexPath.row]
//        cell.textLabel?.text = "Item: \(items[indexPath.row])"
//        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        cell.textLabel?.numberOfLines = 0;
//        
//        return cell
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
    
    @IBAction func clickEdit(sender: UIButton) {
        fcName.userInteractionEnabled = true
        fcAdd1.userInteractionEnabled = true
        fcAdd2.userInteractionEnabled = true
        fcAdd3.userInteractionEnabled = true
        fcMon.userInteractionEnabled = true
        fcTue.userInteractionEnabled = true
        fcWed.userInteractionEnabled = true
        fcThu.userInteractionEnabled = true
        fcFri.userInteractionEnabled = true
        fcSat.userInteractionEnabled = true
        fcSun.userInteractionEnabled = true
        fcRate.userInteractionEnabled = true
    }
    @IBAction func clickSubmit(sender: UIButton) {
        
        let fcname: String, fcadd1: String, fcadd2: String, fcadd3: String
        let fcmon: String, fctue: String, fcwed: String, fcthu: String
        let fcfri: String, fcsat: String, fcsun: String, fcrate: String
        let username: String = globalUserName
        
        fcname = fcName.text!; fcadd1 = fcAdd1.text!; fcadd2 = fcAdd2.text!
        fcadd3 = fcAdd3.text!; fcmon = fcMon.text!; fctue = fcTue.text!
        fcwed = fcWed.text!; fcthu = fcThu.text!; fcfri = fcFri.text!
        fcsat = fcSat.text!; fcsun = fcSun.text!; fcrate = fcRate.text!
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcCreateHP.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = [ "UserName": username, "fcName": fcname, "fcAdd1": fcadd1, "fcAdd2": fcadd2,
            "fcAdd3": fcadd3,"fcMon": fcmon, "fcTue": fctue, "fcWed": fcwed, "fcThu": fcthu,
            "fcFri": fcfri, "fcSat": fcsat, "fcSun": fcsun, "fcRate": fcrate ]
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

    }
    @IBAction func clickpfSubmit(sender: UIButton) {
        
        let UserName: String = globalUserName
        let fcname: String = fcName.text!
        let post: String = postField.text!
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcPostInsert.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = [ "UserName": UserName, "fcName": fcname, "Post": post ]
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
 
                    });

                }
            );
            task.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
        
        let url3:NSURL = NSURL(string: "http://www.hvz-go.com/fcPostPopulate.php")!
        let session3 = NSURLSession.sharedSession()
        
        let request3 = NSMutableURLRequest(URL: url3)
        request3.HTTPMethod = "POST"
        request3.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        do{
            let data3 = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
            let task3 = session3.uploadTaskWithRequest(request3, fromData: data3, completionHandler:
                {(data3,response3,error) in
                    
                    guard let _:NSData = data3, let _:NSURLResponse = response3  where error == nil else {
                        print("error43")
                        return
                    }
                    //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
                    //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
                    do {
                        let response3 = try NSJSONSerialization.JSONObjectWithData(data3!, options: []) as! [String: String]
                        dispatch_async(dispatch_get_main_queue(), {
                            //print(response3)
                            
                            for (key, value) in response3 {
                                print("\(key) , \(value)")
                                self.items.append(value)
                            }
                            
                            for (key, value) in response3 {
                                //print("\(key) , \(value)")
                                self.items[Int(key)!-1] = value
                            }
                            
                            self.tableView.reloadData()
                            
                        });
                        
                        //}
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                }
            );
            task3.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
        

    }
    @IBAction func clickFav(sender: UIButton) {
        
        //let UserName: String = globalUserName
        var fcname: String = fcName.text!
        
        if(globalUserLevel == "u" || globalUserLevel == "a")
        {
            fcname = globalFCSearch
        }

        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcSetFav.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        //print (globalUserName)
        //print(fcname)
        //print("HERE")
        
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
    
//    func getRating() {
//        
//        var ratings:[String] = []
//        var rate:Int = 0
//        var count = 0
//        var found = true
//        let url5:NSURL = NSURL(string: "http://www.hvz-go.com/fcGetRating.php")!
//        let session5 = NSURLSession.sharedSession()
//        
//        let request5 = NSMutableURLRequest(URL: url5)
//        request5.HTTPMethod = "POST"
//        request5.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
//        
//        let dictionary = ["fcName": foodCart]
//        
//        do{
//            let data5 = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
//            //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
//            let task5 = session5.uploadTaskWithRequest(request5, fromData: data5, completionHandler:
//                {(data5,response5,error) in
//                    
//                    guard let _:NSData = data5, let _:NSURLResponse = response5  where error == nil else {
//                        print("error43")
//                        return
//                    }
//                    //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
//                    //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
//                    do {
//                        let response5 = try NSJSONSerialization.JSONObjectWithData(data5!, options: []) as! [String: String]
//                        dispatch_async(dispatch_get_main_queue(), {
//                            //print(response3)
//                            
//                            for (key, value) in response5 {
//                                print("\(key) , \(value)")
//                                ratings.append(value)
//                                if(value == "False")
//                                {
//                                    found = false
//                                }
//                            }
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
//                                    self.fcRate.text = String(rate)
//                                }
//                            }
//                            else {
//                                self.fcRate.text = "0"
//                            }
//                            self.tableView.reloadData()
//                            
//                        });
//                        
//                        //}
//                    } catch let error as NSError {
//                        print("Failed to load: \(error.localizedDescription)")
//                    }
//                    
//                }
//            );
//            task5.resume()
//        }
//        catch {
//            
//            print("error")
//            //Access error here
//        }
//
//        
//    }
    
    func populateHome() {
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcPopulateHome.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let UserName: String = globalUserName
        var fcname: String = fcName.text!
        
        if(globalUserLevel == "u" || globalUserLevel == "a")
        {
            fcname = globalFCSearch
        }
        else if fcname == "" {
            fcname = "temp"
        }
        
        let dictionary = ["UserName": UserName, "fcName": fcname, "fSearch": globalFCSearch]
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
                            self.foodCart = json["fcName"]!
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
    
                            if (json["Owner"] == "true")
                            {
                                self.fcEdit.hidden = false
                                self.fcSubmit.hidden = false
                                self.postField.hidden = false
                                self.pfSubmit.hidden = false
                            }
                            else
                            {
                                self.fcEdit.hidden = true
                                self.fcSubmit.hidden = true
                                self.postField.hidden = true
                                self.pfSubmit.hidden = true
                                
                            }
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
        let fcname:String = fcName.text!
        let request2 = NSMutableURLRequest(URL: url2)
        request2.HTTPMethod = "POST"
        request2.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = ["UserName": globalUserName, "fcName": fcname]
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
                                if(key != "error") {
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
        
        globalFCSearch = fcName.text!

        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("writeReview") as! fcWriteReviewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func clickGotoReviews(sender: UIButton) {
        
        globalFCSearch = fcName.text!
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("viewReview") as! fcReviewController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func clickMenu(sender: UIButton) {
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("menuViewController") as! MenuViewController
        self.presentViewController(resultViewController, animated:true, completion:nil)

    }

}

