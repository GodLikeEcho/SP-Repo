//
//  fcMapViewController.swift
//  FCTracker
//
//  Created by Clint Jellesed on 3/16/17.
//  Copyright © 2017 Clint Jellesed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class fcMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var searchField: UITextField!
    var coords: CLLocationCoordinate2D?
    
//    override func viewWillAppear(animated: Bool) {
//        if globalFCSearch != "" {
//            populateHome()
//        }
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.delegate = self
        let initialLocation = CLLocation(latitude: 42.218595, longitude: -121.774962)
        centerMapOnLocation(initialLocation)
        //globalFCSearch = ""
        if globalFCSearch != "" {
            get()
        }
        //getDirections()
        }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    
    let regionRadius: CLLocationDistance = 15000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func getDirections() {
        //change this
        let addressString = "\(globalFCSearch) \(globalFCSearch) \(globalFCSearch)"
        
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    self.coords = location!.coordinate
                    //self.showMap()
                    //self.addPin()
                }
        })
    }
    
    func addPin(name:String, loc:String) {
        print(coords)
        let artwork = MapPinClass(title: name,
                                  locationName: loc,
                                  coordinate: coords!) //CLLocationCoordinate2D(latitude: 42.228719, longitude: -121.718591))
        
            
        mapView.addAnnotation(artwork)

    }
    
    func get() {
        let url:NSURL = NSURL(string: "http://www.hvz-go.com/fcPopulateHome.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let dictionary = ["UserName": globalUserName, "fcName": globalFCSearch, "fSearch": globalFCSearch]
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
                            
                            var addressString:String = ""
                            addressString.appendContentsOf(json["fcAdd1"]!)
                            addressString.appendContentsOf(" ")
                            addressString.appendContentsOf(json["fcAdd2"]!)
                            addressString.appendContentsOf(" ")
                            addressString.appendContentsOf(json["fcAdd3"]!)
                            //let addressString = "\(json["fcAdd1"]) \(json["fcAdd2"]) \(json["fcAdd3"])"
                            //let addressString = "5540 Benchwood Ave. Klamath Falls, OR 97603"
                            print(addressString)
                            let xName:String = json["fcName"]!
                            let xLoc:String = json["fcAdd1"]!
                            CLGeocoder().geocodeAddressString(addressString, completionHandler:
                                {(placemarks, error) in
                                    
                                    if error != nil {
                                        print("Geocode failed: \(error!.localizedDescription)")
                                    } else if placemarks!.count > 0 {
                                        let placemark = placemarks![0]
                                        let location = placemark.location
                                        self.coords = location!.coordinate
                                        //self.showMap()
                                        self.addPin(xName, loc: xLoc)
                                    }
                            })

                        });
                        
                        //}
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                    
                    //here
                }
            );
            task.resume()
        }
        catch {
            
            print("error")
            //Access error here
        }
    }

    @IBAction func clickSearch(sender: UIButton) {
        globalFCSearch = searchField.text!
        get()
    }
    
    @IBAction func clickClear(sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
    }
}


