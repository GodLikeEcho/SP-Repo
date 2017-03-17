//
//  MapPinClass.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/16/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import MapKit

class MapPinClass: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    //let discipline: String
    @objc let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        //self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }

}
