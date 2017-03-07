//
//  customReviewTableViewCell.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/2/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit

class CustomReviewTableViewCell: UITableViewCell {
    
//    @IBOutlet var fcName: UILabel!
//    @IBOutlet var fcLocation: UILabel!
//    @IBOutlet var fcHours: UILabel!
//    @IBOutlet var fcRate: UILabel!
    @IBOutlet var fcName: UILabel!
    @IBOutlet var reviewTextView: UITextView!
    @IBOutlet var fcRate: UILabel!
    
    @IBOutlet var fcName2: UILabel!
    @IBOutlet var reviewTextView2: UITextView!
    @IBOutlet var fcRate2: UILabel!
    
    
    let lightGreen = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
    let lightRed = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
    
    //let discount = 0.1
    
    //    func string(_ prefix:String, for price:Double) -> String{
    //        let priceString = String(format: "%2.2f", price)
    //        return prefix + priceString
    //    }
    
    func set(Name:String, Post:String, Rate:String){
        
        fcName.text = Name
        reviewTextView.text = Post
        fcRate.text = Rate
        contentView.backgroundColor = lightGreen
    }
    
    func set2(Name:String, Post:String, Rate:String){
        
        fcName2.text = Name
        reviewTextView2.text = Post
        fcRate2.text = Rate
        contentView.backgroundColor = lightGreen
    }

}

