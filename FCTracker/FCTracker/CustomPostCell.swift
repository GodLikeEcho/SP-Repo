//
//  CustomPostCell.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/6/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class CustomPostCell: UITableViewCell {
    
    //    @IBOutlet var fcName: UILabel!
    //    @IBOutlet var fcLocation: UILabel!
    //    @IBOutlet var fcHours: UILabel!
    //    @IBOutlet var fcRate: UILabel!
    @IBOutlet var fcName22: UILabel!
    @IBOutlet var fcPost22: UITextView!

    @IBOutlet var fcName: UILabel!
    @IBOutlet var fcPost: UITextView!
    
    @IBOutlet var fcName33: UILabel!
    @IBOutlet var fcPost33: UITextView!
    

    //@IBOutlet var fcName2: UILabel!
    //@IBOutlet var fcPost2: UITextView!
    
    
    let lightGreen = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
    let lightRed = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
    
    //let discount = 0.1
    
    //    func string(_ prefix:String, for price:Double) -> String{
    //        let priceString = String(format: "%2.2f", price)
    //        return prefix + priceString
    //    }
    
    func set2(Name:String, Post:String){
        
        fcName22.text = Name
        fcPost22.text = Post
        
        //fcRate.text = Rate
        contentView.backgroundColor = lightGreen
    }
    
    func set(Name:String, Post:String){
        
          fcName.text = Name
          fcPost.text = Post
//        fcRate2.text = Rate
        contentView.backgroundColor = lightGreen
    }
    
    func set3(Name:String, Post:String){
        
        fcName33.text = Name
        fcPost33.text = Post
        //        fcRate2.text = Rate
        contentView.backgroundColor = lightGreen
    }
    
}
