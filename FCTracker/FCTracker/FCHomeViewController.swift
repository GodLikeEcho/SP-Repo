//
//  FirstViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 1/26/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class FCHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
                            }
                            else
                            {
                                self.fcEdit.hidden = true
                                self.fcSubmit.hidden = true
                                
                            }
                        });
                        
                        //}
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    //let json = try NSJSONSerialization.dataWithJSONObject(with: data, options: .PrettyPrinted) as? [String:Any]
                    //let dataString = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: Any]
                    //let dataString = try NSJSONSerialization.dataWithJSONObject(with: response!, options: .PrettyPrinted)
                    //let dic = NSJSONSerialization.JSONObjectWithData(response, options: nil) as NSDictionary
                    //jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    //let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    //print("This is it")
                    //print(UserName)
                    //print(fcname)
                    //print(dataString)
                    
                    //self.fcName.text = dict["fcName"]
                    //self.fcName.text = dataString as? String
                                    }
            );
            task.resume()
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
    
}

