//
//  AppDelegate.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let notificationTypes: UIRemoteNotificationType = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert
        
        UIApplication.sharedApplication().registerForRemoteNotificationTypes(notificationTypes)
        
        let apnsCertName: String = "spiriiitadmin"
        
        EaseMob.sharedInstance().registerSDKWithAppKey("spiriiit#spiriiittradeserver", apnsCertName: apnsCertName)
        EaseMob.sharedInstance().chatManager.autoFetchBuddyList = true
        
        EaseMob.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
      //  EaseMob.sharedInstance().chatManager.removeDelegate(self)
       // EaseMob.sharedInstance().chatManager.addDelegate(self, delegateQueue: nil)
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillResignActive(application)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        EaseMob.sharedInstance().applicationDidEnterBackground(application)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillEnterForeground(application)
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        EaseMob.sharedInstance().applicationDidBecomeActive(application)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillTerminate(application)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func registerRemoteNotification() {
        var application: UIApplication = UIApplication.sharedApplication()
        if application.respondsToSelector("registerForRemoteNotification") {
            application.registerForRemoteNotifications()
            let notificationTypes: UIUserNotificationType = UIUserNotificationType.Badge | UIUserNotificationType.Sound | UIUserNotificationType.Alert
            var settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            
        } else {
            var notificationTypes: UIRemoteNotificationType = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(notificationTypes)
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        EaseMob.sharedInstance().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
        var myAlert = UIAlertView(title: "注册推送失败",
            message: error.description,
            delegate: nil, cancelButtonTitle: "确定"
        )
        myAlert.show()
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        EaseMob.sharedInstance().application(application, didReceiveRemoteNotification: userInfo)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        EaseMob.sharedInstance().application(application, didReceiveLocalNotification: notification)
    }
}

