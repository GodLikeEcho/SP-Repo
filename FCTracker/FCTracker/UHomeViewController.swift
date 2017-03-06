//
//  UHomeViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 2/9/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

//import Foundation
import UIKit

var globalFCSearch:String = ""

class UHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var reviewTableView: UITableView!
    @IBOutlet var feedTableView: UITableView!
    
    var fcFavorites: [String] = []//["FC!!!", "fc42" , "fc42" , "Food Cart Name"]
    var fName: [String] = []
    var fLocation: [String] = []
    var fHours: [String] = []
    var fRate: [String] = []
    var fDay: String = "fcMon"
    var count: Int = 0
    
    var fcReviews: [String] = []//["FC!!!", "fc42" , "fc42" , "Food Cart Name"]
    var frName: [String] = []
    var frPost: [String] = []
    var frRate: [String] = []
    var rcount: Int = 0
    
    var items:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+1000)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        getFav(globalUserName)
        //populateCells(fcFavorites, Day: fDay)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int = 0
        if tableView == self.tableView {
            count = fcFavorites.count
        }
        
        if tableView == self.reviewTableView {
            count =  0//sampleData1.count
        }
        if tableView == self.feedTableView {
            count =  0//sampleData1.count
        }
        return count
        //return fcFavorites.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.tableView {
        let cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomTableViewCell
            
            if fcFavorites.count > 0 && indexPath.row <= count - 1 {
                print(indexPath.row)
                cell.set(fName[indexPath.row], Locaton: fLocation[indexPath.item], Hours: fHours[indexPath.item], Rate: fRate[indexPath.item])
            }
            else {
                cell.set("Temp", Locaton: "Temp", Hours: "Temp", Rate: "Temp")
            }
            return cell
        }
        
        if tableView == self.reviewTableView {
            let cell:CustomReviewTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomReviewTableViewCell
            
            if frPost.count > 0 && indexPath.row <= count - 1 {
                print(indexPath.row)
                cell.set(frName[indexPath.row], Post: frPost[indexPath.item], Rate: frRate[indexPath.item])
                //globalFCSearch = fName[indexPath.row]
            }
            else {
                cell.set("Temp", Post: "Temp", Rate: "Temp")
            }
            return cell
        }
        
        if tableView == self.feedTableView {
            let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            
            //let item = items[indexPath.row]
            cell.textLabel?.text = "Item: \(items[indexPath.row])"
            cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell.textLabel?.numberOfLines = 0;
            
            return cell

        }

        return cell!
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
                                self.fRate.append(json["fcRate"]!)
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
    
    func getFav(UserName: String) {
        
        let url2:NSURL = NSURL(string: "http://www.hvz-go.com/fcGetFav.php")!
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
                                self.fcFavorites.append("False")
                                self.populateCells("False")
                            }
                            else {
                                
                                for (key, value) in response2 {
                                    print("\(key) , \(value)")
                                    self.fcFavorites.append(value)
                                }
                                
                                for (key, value) in response2 {
                                    //print("\(key) , \(value)")
                                    self.fcFavorites[Int(key)!-1] = value
                                }
                                
                                self.populateCells(self.fcFavorites, Day: self.fDay)
                            }
                            //self.tableView.reloadData()
                            
                        });
                        
                    } catch let error as NSError {
                        print("Failed to load 45: \(error.localizedDescription)")
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
    
}
