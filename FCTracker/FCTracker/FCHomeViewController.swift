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
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcPopulateHome.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let UserName: String = globalUserName
        let fcname: String = fcName.text!
        
        let dictionary = ["UserName": UserName, "fcName": fcname]
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
                            self.fcName.text = json["fcName"]
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
                            self.fcRate.text = json["fcRate"]
                            //self.fcName.text = dataString as? String
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
        
        let url2:NSURL = NSURL(string: "http://www.hvz-go.com/fcPostPopulate.php")!
        let session2 = NSURLSession.sharedSession()
        
        let request2 = NSMutableURLRequest(URL: url2)
        request2.HTTPMethod = "POST"
        request2.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        //let UserName: String = globalUserName
        //let fcname: String = fcName.text!
        
        //let dictionary = ["UserName": UserName, "fcName": fcname]
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
                            print(response2)
                            self.items.append(response2["Post"]!)
                            print(self.items[0])
//                            if (json["Owner"] == "true")
//                            {
//                                self.fcEdit.hidden = false
//                                self.fcSubmit.hidden = false
//                                self.postField.hidden = false
//                                self.pfSubmit.hidden = false
//                            }
//                            else
//                            {
//                                self.fcEdit.hidden = true
//                                self.fcSubmit.hidden = true
//                                self.postField.hidden = true
//                                self.pfSubmit.hidden = true
//                                
//                            }
                        });
                        
                        //}
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
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
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        //let item = items[indexPath.row]
        cell.textLabel?.text = "Item: \(items[indexPath.row])"
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel?.numberOfLines = 0;
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var returnValue = CGFloat()
        
        if (items.count > 0) {
            let stringData = items[indexPath.row] as NSString
            let constraintRect = CGSize(width: 280.0, height: CGFloat.max)
            //get height of the string used
            let boundingBox = stringData.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15.0)], context: nil)
            return boundingBox.height + CGFloat(85.0)
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

