//
//  fcReviewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/2/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class fcReviewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fcReviews: [String] = []//["FC!!!", "fc42" , "fc42" , "Food Cart Name"]
    var fName: [String] = []
    var fPost: [String] = []
    var fRate: [String] = []
    var count: Int = 0
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //rating = "1"
        tableView.dataSource = self
        tableView.delegate = self
        getReview(globalFCSearch)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fPost.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomReviewTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customReviewCell", forIndexPath: indexPath) as! CustomReviewTableViewCell 
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        //let row = indexPath.row
        //print(cell2)
        //let x: Int = 0
        //        while x < count {
        //            cell.set(fName[x], Locaton: fLocation[x], Hours: fHours[x], Rate: fRate[x])
        //        }
        if fPost.count > 0 && indexPath.row <= count - 1 {
            print(indexPath.row)
            cell.set(fName[indexPath.row], Post: fPost[indexPath.item], Rate: fRate[indexPath.item])
            //globalFCSearch = fName[indexPath.row]
        }
        else {
            cell.set("Temp", Post: "Temp", Rate: "Temp")
        }
        //cell.set(fName[count], Locaton: fLocation[count], Hours: fHours[count], Rate: fRate[count])
        
        //cell.set(fName[indexPath.row], Locaton: fLocation[indexPath.row], Hours: fHours[indexPath.row], Rate: fRate[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        //let cell = tableView.cellForRowAtIndexPath(indexPath)
        //globalFCSearch = fName[indexPath.row]
        //print(globalFCSearch)
        //let storyBoard : UIStoryboard = self.storyboard!
        //let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
        //self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var returnValue = CGFloat()
        
        if (fPost.count > 0) {
            let stringData = fPost[indexPath.row] as NSString
            let constraintRect = CGSize(width: 280.0, height: CGFloat.max)
            //get height of the string used
            let boundingBox = stringData.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil)
            return boundingBox.height + CGFloat(45.0)
        }
        else{
            returnValue = CGFloat(85.0);
        }
        return returnValue;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func getReview(fcName:String)
    {
        let url3:NSURL = NSURL(string: "http://www.hvz-go.com/fcPopulateReviewCell.php")!
        let session3 = NSURLSession.sharedSession()
        
        let request3 = NSMutableURLRequest(URL: url3)
        request3.HTTPMethod = "POST"
        request3.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        //let UserName: String = globalUserName
        //let fcname: String = fcName.text!
        
        let dictionary = ["fcName": fcName]
        //print(dictionary)
        do{
            let data3 = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
            //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
            let task3 = session3.uploadTaskWithRequest(request3, fromData: data3, completionHandler:
                {(data3,response3,error) in
                    
                    guard let _:NSData = data3, let _:NSURLResponse = response3  where error == nil else {
                        print("error23")
                        return
                    }
                    //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
                    //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
                    do {
                        let response3 = try NSJSONSerialization.JSONObjectWithData(data3!, options: []) as! [String: String]
                        dispatch_async(dispatch_get_main_queue(), {
                            //print( "you are here")
                            print(response3)
                            //print("your are past")
                            //let i:Int = 0
                            if(response3["UserName"] == "False")
                            {
                                self.fcReviews.append("False")
                                self.fName.append("Null")
                                self.fPost.append("Food Cart has no reviews")
                                self.fRate.append("Null")
                                //self.populateCells("False")
                            }
                            else {
                                var searchCharacter: Character = "p"
                                var loc = 0;
                                for (key, value) in response3 {
                                    print("\(key) , \(value)")

                                    searchCharacter = "u"
                                    if key.lowercaseString.characters.contains(searchCharacter) && key != "UserName" {
                                        self.fName.append(response3[key]!)
                                    }
                                    searchCharacter = "p"
                                    if key.lowercaseString.characters.contains(searchCharacter) && key != "UserName" {
                                        self.fPost.append(response3[key]!)
                                    }
                                    searchCharacter = "r"
                                    if key.lowercaseString.characters.contains(searchCharacter) && key != "UserName" {
                                        self.fRate.append(response3[key]!)
                                    }
                                    self.count += 1
                                    //self.fcFavorites.append(value)
                                }
//                                    for (key, value) in response3 {
//                                    //print("\(key) , \(value)")
//                                    searchCharacter = "p"
//                                    if key.lowercaseString.characters.contains(searchCharacter) {
//                                        self.fPost[loc] = value
//                                    }
//                                    searchCharacter = "r"
//                                    searchCharacter = "r"
//                                    if key.lowercaseString.characters.contains(searchCharacter) {
//                                        self.fRate[loc] = value
//                                    }
//                                        loc += 1
//                                }
                                
                                //self.populateCells(self.fcFavorites, Day: self.fDay)
                            }
                            self.tableView.reloadData()
                            
                        });
                        
                    } catch let error as NSError {
                        print("Failed to load 45: \(error.localizedDescription)")
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
    
    func populateCells(value:String)
    {
        self.fName.append("User has no favorites")
        self.fPost.append("")
        self.fRate.append("")
        self.tableView.reloadData()
        self.count += 1
        
    }
    
    func populateCells(Reviews: [String], Post: [String], Rate: [String]) {
        
        
    }
//    func populateCells(Favorites: [String], Day: String) {
//        for index in Favorites
//        {
//            let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcPopulateFCell.php")!
//            let session = NSURLSession.sharedSession()
//            
//            let request = NSMutableURLRequest(URL: url)
//            request.HTTPMethod = "POST"
//            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
//            //let UserName: String = globalUserName
//            let fcname: String = index
//            
//            let dictionary = ["fcName": fcname, "$fcTimeDay": Day]
//            do{
//                let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
//                //let data = try NSJSONSerialization.JSONObjectWi(dictionary, options: .mutableContainers) as? [String:Any]
//                let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
//                    {(data,response,error) in
//                        
//                        guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
//                            print("error")
//                            return
//                        }
//                        //let str = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
//                        //let data = response(using: String.Encoding.utf8, allowLossyConversion: false)!
//                        do {
//                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: String]
//                            dispatch_async(dispatch_get_main_queue(), {
//                                print(json)
//                                self.fName.append(json["fcName"]!)
//                                self.fLocation.append(json["fcAdd1"]!)
//                                self.fHours.append(json["fcDay"]!)
//                                self.fRate.append(json["fcRate"]!)
//                                self.tableView.reloadData()
//                                self.count += 1
//                                
//                            });
//                            
//                            //}
//                        } catch let error as NSError {
//                            print("Failed to load: \(error.localizedDescription)")
//                        }
//                        
//                    }
//                );
//                task.resume()
//            }
//            catch {
//                
//                print("error")
//                //Access error here
//            }
//            
//        }
//        
//    }

    @IBAction func clickBack(sender: UIButton) {
        let storyBoard : UIStoryboard = self.storyboard!
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("FCTab") as! UITabBarController
        self.presentViewController(resultViewController, animated:true, completion:nil)

    }

}

