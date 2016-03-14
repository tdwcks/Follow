//
//  AppDelegate.swift
//  Follow
//
//  Created by Tom Wicks on 14/03/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit
import PubNub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }
    
    // Instance property
    var client: PubNub?
    
    // For demo purposes the initialization is done in the init function so that
    // the PubNub client is instantiated before it is used.
    override init() {
        
        // Instantiate configuration instance.
        let configuration = PNConfiguration(publishKey: "pub-c-2abab4a3-189a-4355-b694-bd63a2ff00ae", subscribeKey: "sub-c-86d2f1ae-e9f8-11e5-bf9d-02ee2ddab7fe")
        // Instantiate PubNub client.
        client = PubNub.clientWithConfiguration(configuration)
        
        super.init()
        client?.addListener(self)
        
        self.client?.publish("Hello from the PubNub Swift SDK", toChannel: "my_channel",
            compressed: false, withCompletion: { (status) -> Void in
                
                if !status.error {
                    print("Wooooo")
                }
                else{
                    print("Fucked it")
            
                }
        })
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


