//
//  UHomeViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 2/9/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

//import Foundation
import UIKit

class UHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+1000)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//items.count
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
//        
//        //let item = items[indexPath.row]
//        //cell.textLabel?.text = "Item: \(items[indexPath.row])"
//        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        //cell.textLabel?.numberOfLines = 0;
//        
//        return cell
//    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomTableViewCell
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        //let row = indexPath.row
        //print(cell2)
        cell.set("Test", Locaton: "temp", Hours: "trrr", Rate: "yolo")
        return cell
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var returnValue = CGFloat()
//        
//        returnValue = CGFloat(85.0);
//        return returnValue;
//    }
//    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
}
