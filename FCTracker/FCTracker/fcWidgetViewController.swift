//
//  fcWidgetViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/15/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class fcWidgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var findField: UITextField!
    @IBOutlet var tableView: UITableView!
    var foodcarts: [String] = []
    var fName: [String] = []
    var fLocation: [String] = []
    var fHours: [String] = []
    var fRate: [String] = []
    var fDay: String = "fcMon"
    var count: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        getCarts(globalUserName)
        print(fName)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickFind(sender: UIButton) {
        //print("You selected cell #\(indexPath.row)!")
        //let cell = tableView.cellForRowAtIndexPath(indexPath)
        globalFCSearch = findField.text!
        print(globalFCSearch)
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodcarts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell:UITableViewCell?
        let cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("fcAllCell", forIndexPath: indexPath) as! CustomTableViewCell
            
        if foodcarts.count > 0 && indexPath.row <= count - 1 {
            print(indexPath.row)
            cell.set2(fName[indexPath.row], Locaton: fLocation[indexPath.item], Hours: fHours[indexPath.item], Rate: fRate[indexPath.item])
        }
        else {
            cell.set2("Temp", Locaton: "Temp", Hours: "Temp", Rate: "Temp")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var returnValue = CGFloat()
        returnValue = CGFloat(85.0);
        return returnValue;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        //let cell = tableView.cellForRowAtIndexPath(indexPath)
        globalFCSearch = fName[indexPath.row]
        print(globalFCSearch)
        if tableView == self.tableView {
            let storyBoard : UIStoryboard = self.storyboard!
            let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
            self.presentViewController(resultViewController, animated:true, completion:nil)
        }
    }

    func getCarts(UserName: String) {
        
        let url2:NSURL = NSURL(string: "http://www.hvz-go.com/fcGetCarts.php")!
        let session2 = NSURLSession.sharedSession()
        
        let request2 = NSMutableURLRequest(URL: url2)
        request2.HTTPMethod = "POST"
        request2.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        //let UserName: String = globalUserName
        //let fcname: String = fcName.text!
        
        let dictionary = ["UserName": UserName]
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
                            print(response2)
                            //print("your are past")
                            //let i:Int = 0
                            if(response2["1"] == "False")
                            {
                                self.foodcarts.append("False")
                                self.populateCells("False")
                            }
                            else {
                                
                                for (key, value) in response2 {
                                    print("\(key) , \(value)")
                                    self.foodcarts.append(value)
                                }
                                
                                //                                for (key, value) in response2 {
                                //                                    //print("\(key) , \(value)")
                                //                                    self.fcFavorites[Int(key)!-1] = value
                                //                                }
                                
                                self.populateCells(self.foodcarts, Day: self.fDay)
                            }

                            //print(self.items)
                            
                        });
                        
                    } catch let error as NSError {
                        print("Failed to load 49: \(error.localizedDescription)")
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

    func populateCells(value:String) {
        self.fName.append("User has no favorites")
        self.fLocation.append("")
        self.fHours.append("")
        self.fRate.append("")
        self.tableView.reloadData()
        self.count += 1
    }
    
    func populateCells(Favorites: [String], Day: String) {
        for index in Favorites
        {
            let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcPopulateFCell.php")!
            let session = NSURLSession.sharedSession()
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            //let UserName: String = globalUserName
            let fcname: String = index
            
            let dictionary = ["fcName": fcname, "$fcTimeDay": Day]
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
                                self.fName.append(json["fcName"]!)
                                self.fLocation.append(json["fcAdd1"]!)
                                self.fHours.append(json["fcDay"]!)
                                self.fRate.append(json["calcRate"]!)
                                self.tableView.reloadData()
                                self.count += 1
                                
                            });
                            
                            //}
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                        
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

}
