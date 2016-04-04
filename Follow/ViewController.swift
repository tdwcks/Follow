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

@objc class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, PNObjectEventListener {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var findMeButton: UIButton!
    @IBOutlet weak var customTextField: UITextField!
    
    let locationManager = CLLocationManager()
    
    let configuration = PNConfiguration(publishKey: "pub-c-2abab4a3-189a-4355-b694-bd63a2ff00ae", subscribeKey: "sub-c-86d2f1ae-e9f8-11e5-bf9d-02ee2ddab7fe")
    
    var client: PubNub?
    
    var crumbPath: CrumbPath?
    var crumbPathRenderer: CrumbPathRenderer?
    
    @IBAction func centreOnUser(sender: AnyObject) {
        mapView.userTrackingMode = .Follow
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        client = PubNub.clientWithConfiguration(configuration)
        client?.addListener(self)
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5.0
        self.locationManager.startUpdatingLocation()
        self.mapView.delegate = self
        self.mapView.userTrackingMode = .Follow
        self.mapView.showsUserLocation = true
    }

    func addCrumbPoint(point:CLLocationCoordinate2D) {
        
        if let _ = crumbPath {
            
            //var boundingMapRectChanged = false
            crumbPath!.addCoordinate(point)
            
            mapView.removeOverlay(crumbPath!)
            crumbPathRenderer = nil
            mapView.addOverlay(crumbPath!)
            
        }
        else {
            crumbPath = CrumbPath(centerCoordinate:point)
            mapView.addOverlay(crumbPath!)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay.isKindOfClass(CrumbPath)) {
            if let _ = crumbPathRenderer {
            }
            else {
                crumbPathRenderer = CrumbPathRenderer(overlay:overlay)
            }
            return crumbPathRenderer!
        }
        return MKTileOverlayRenderer(overlay: overlay)
    }
    
    // Mark Location Delegate Methods 
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        addCrumbPoint(center)
        let message = "{\"lat\":\(location!.coordinate.latitude),\"lng\":\(location!.coordinate.longitude), \"alt\": \(location!.altitude)}"
        
        self.client?.publish(message, toChannel: "my_channel",
            compressed: false, withCompletion: { (status) -> Void in
                
                if !status.error {
                    print("Wooooo")
                }
                else{
                    print("Fucked it")
                    
                }
        })
        
        print(message)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        if(!isUserLoggedIn) {
            self.performSegueWithIdentifier("loginView", sender: self);
        }
    }
    
    @IBAction func logOutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("loginView", sender: self);
    }
}

