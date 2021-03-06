//
//  AppDelegate.swift
//  Instagram
//
//  Created by Aarnav Ram on 16/03/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration :ParseMutableClientConfiguration) in
            configuration.applicationId = "Instagram"
            configuration.clientKey = "12345678"  // set to nil assuming you have not set clientKey
            configuration.server = "https://ig-clone-app.herokuapp.com/parse"
            
        }))
        
        
        
        if PFUser.current() != nil {
            let navController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        } else {
            
            window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "logout"), object: nil, queue: OperationQueue.main) { (Notification) in
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

