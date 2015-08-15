

//
//  AppDelegate.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/20/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Mixpanel.sharedInstanceWithToken("c661c091a83398e973d261e007fcb367")
        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("App launched")
        
    Parse.setApplicationId("XNC5GfNCY1zmSZb48T246rZ85qR4gyb14nvZrRTm", clientKey: "ndNDzJSDeQRKvYcnicCbU8f1jIGEc15uD5TXxWpP")
        
        //PFUser.logInWithUsername("LaIkHtEwArIiSaNaDmIn", password: "ThIsIsMyPaSsWoRd2000")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let username = defaults.objectForKey("username") as? String
        {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let navigationController = storyBoard.instantiateViewControllerWithIdentifier("TabBarController") as! UIViewController
//            self.window?.rootViewController?.presentViewController(navigationController, animated: true, completion: nil)
            if let password = defaults.objectForKey("password") as? String
            {
                PFUser.logInWithUsernameInBackground(username, password: password, block: { (user: PFUser?, error: NSError?) -> Void in
                    if let error = error
                    {
                        PFUser.logInWithUsernameInBackground(username, password: password, block: { (user2: PFUser?, error2: NSError?) -> Void in
                            if let error2 = error2
                            {
                                
                            }
                            else{
                                println("logged in")
                            }
                        })
                    }
                    else
                    {
                        println("logged in on first try")
                    }
                })
            }
        }
        
        let acl = PFACL()
        acl.setPublicReadAccess(true)
        PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
        
        return true
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

