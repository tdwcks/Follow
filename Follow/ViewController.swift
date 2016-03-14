//
//  ViewController.swift
//  Follow
//
//  Created by Tom Wicks on 14/03/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import PubNub

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let configuration = PNConfiguration(publishKey: "pub-c-2abab4a3-189a-4355-b694-bd63a2ff00ae", subscribeKey: "sub-c-86d2f1ae-e9f8-11e5-bf9d-02ee2ddab7fe")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    // Mark Location Delegate Methods 
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        let message = "{\"lat\":\(location!.coordinate.latitude),\"lng\":\(location!.coordinate.longitude), \"alt\": \(location!.altitude)}"
        
        print(message)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
}

