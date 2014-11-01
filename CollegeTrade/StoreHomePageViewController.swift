//
//  StoreHomePageViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/30/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class StoreHomePageViewController: UIViewController {  
    
    var recommendedStores = [UIButton]()
    
    var recommendedStoresId = [Int]()
    
    
    var selectedStoreIndex = -1
   
    
    
    func initAppParameter() {
        DataBaseAPIHelper.getNews { (success: Bool, data: NSDictionary?) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {
                    println(data)
                    UPYUN_IMAGE_SERVER = data!["imageServer"] as String
                    UPYUN_IMAGE_SPACE = data!["ImageSpace"] as String
                    UPYUN_BUCKET = data!["imageBucket"] as String
                    APP_VERSION = data!["version"] as Double
                }
            })
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        // 初始参数
        initAppParameter()
        // check if user has saved login credential
        if USER_IS_LOGGED_IN == false {
            println("is false")
            var storedUsername = KeychainService.loadToken("SPIRIIITCOLLEGETRADEUSERNAME")
            if (storedUsername != nil && storedUsername! != "") {
                var storedPassword = KeychainService.loadToken("SPIRIIITCOLLEGETRADEPASSWORD")
                DataBaseAPIHelper.checkLoginCredential(storedUsername!, password: storedPassword!) { (success: Bool) -> () in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if success {
                            USER_IS_LOGGED_IN = true
                            EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(storedUsername, password: storedPassword, completion:
                                { response, error in
                                    if ((error) != nil) {
                                        println("cannot login")
                                        println(error)
                                    } else {
                                        println("success")
                                    }
                                    
                                }, onQueue: nil)
                            
                        }
                    })
                }
            }
        }
        
        let mainScreenWidth = UIScreen.mainScreen().bounds.width
        println(mainScreenWidth)
        
        var pictureWidth = (mainScreenWidth - 100) / 3
        var pictureHeight = pictureWidth * 400 / 600.0
        
        for i in 0...2 {
            var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            var j = CGFloat(i)
            var xLocation = j * (pictureWidth + 20.0) + 30.0
            button.frame = CGRectMake(xLocation, 300, pictureWidth, pictureHeight)
            button.setImage(UIImage(named:"opensoon.jpg"), forState: UIControlState.Normal)
            button.tag = i
            button.addTarget(self, action: "showStore:", forControlEvents: .TouchUpInside)
            recommendedStores.append(button)
            self.view.addSubview(button)

        }
        
        for i in 0...2 {
            var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            var j = CGFloat(i)
            var xLocation = j * (pictureWidth + 20.0) + 30.0
            button.frame = CGRectMake(xLocation, 300 + pictureHeight + 10, pictureWidth, pictureHeight)
            button.setImage(UIImage(named:"opensoon.jpg"), forState: UIControlState.Normal)
            button.tag = i + 3
            button.addTarget(self, action: "showStore:", forControlEvents: .TouchUpInside)
            recommendedStores.append(button)
            self.view.addSubview(button)
            
        }
        for i in 0...2 {
            var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            var j = CGFloat(i)
            var xLocation = j * (pictureWidth + 20.0) + 30.0
            button.frame = CGRectMake(xLocation, 300 + (pictureHeight + 10) * 2, pictureWidth, pictureHeight)
            button.setImage(UIImage(named:"opensoon.jpg"), forState: UIControlState.Normal)
            button.tag = i + 6
            button.addTarget(self, action: "showStore:", forControlEvents: .TouchUpInside)
            recommendedStores.append(button)
            self.view.addSubview(button)
            
        }
       
    }
    
    func showStore(sender: UIButton!) {
        
        println("\(sender.tag) tapped")
        selectedStoreIndex = sender.tag
        performSegueWithIdentifier("ShowUserStoreHomePageSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(UserStoreHomePageViewController) {
            if segue.identifier == "ShowUserStoreHomePageSegue" {
                var storeViewController: UserStoreHomePageViewController = segue.destinationViewController as UserStoreHomePageViewController
                storeViewController.userIdForThisStore = 1
            }
        }
   
    }
}

