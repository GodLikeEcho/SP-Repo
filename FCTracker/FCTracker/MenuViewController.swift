//
//  MenuViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/7/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var fcOwner = false
    @IBOutlet var uploadImageButton: UIButton!
    @IBOutlet var selectImageButton: UIButton!
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        uploadImageButton.hidden = true
//        selectImageButton.hidden = true
        checkOwner()
        var theurl:String = "http://hvz-go.com/Images/"
        theurl.appendContentsOf(globalFCSearch)
        theurl.appendContentsOf(".jpg")
        print(theurl)
        myImageView.imageFromUrl(theurl)
        //"http://hvz-go.com/Images/fc.jpg"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickUploadImage(sender: UIButton) {
        myImageUploadRequest()
    }
    
    @IBAction func clickSelectImage(sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://www.hvz-go.com/fcUploadImage.php");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [ "UserName" : globalUserName ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                
                print(json)
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.myActivityIndicator.stopAnimating()
                    //self.myImageView.image = nil;
                });
                
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        var filename = globalFCSearch //".jpg"
        filename.appendContentsOf(".jpg")
        print(filename)
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
        
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
    
    func checkOwner() {
        
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcCheckOwner.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        //let data = "data=Hi".dataUsingEncoding(NSUTF8StringEncoding)
        let dictionary = ["UserName": globalUserName, "fcName": globalFCSearch]
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
                    dispatch_async(dispatch_get_main_queue(), {
                    if (dataString == "\"true\"") {
                        //self.fcOwner = true
                        self.uploadImageButton.hidden = false
                        self.selectImageButton.hidden = false
                    }
                    else {
                        self.uploadImageButton.hidden = true
                        self.selectImageButton.hidden = true
                        
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
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
