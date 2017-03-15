//
//  CustomTableViewCell.swift
//  FCTracker
//
//  Created by Clint Jellesed on 2/28/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

//import Cocoa
import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var fcName: UILabel!
    @IBOutlet var fcLocation: UILabel!
    @IBOutlet var fcHours: UILabel!
    @IBOutlet var fcRate: UILabel!
    
    @IBOutlet var fcName2: UILabel!
    @IBOutlet var fcLocation2: UILabel!
    @IBOutlet var fcHours2: UILabel!
    @IBOutlet var fcRate2: UILabel!
    
    
    let lightGreen = UIColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
    let lightRed = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
    
    //let discount = 0.1
    
//    func string(_ prefix:String, for price:Double) -> String{
//        let priceString = String(format: "%2.2f", price)
//        return prefix + priceString
//    }
    
    func set(Name:String, Locaton:String, Hours:String, Rate:String){
        
            fcName.text = Name
            fcLocation.text = Locaton
            fcHours.text = Hours
            fcRate.text = Rate
            contentView.backgroundColor = lightGreen
    }
    
    func set2(Name:String, Locaton:String, Hours:String, Rate:String){
        fcName2.text = Name
        fcLocation2.text = Locaton
        fcHours2.text = Hours
        fcRate2.text = Rate
        contentView.backgroundColor = lightGreen
    }
}
