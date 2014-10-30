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
    @IBAction func clicked(sender: AnyObject) {
        println("clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            button.setImage(UIImage(named:"randomcat1.png"), forState: UIControlState.Normal)
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
            button.setImage(UIImage(named:"randomcat1.png"), forState: UIControlState.Normal)
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
            button.setImage(UIImage(named:"randomcat1.png"), forState: UIControlState.Normal)
            button.tag = i + 6
            button.addTarget(self, action: "showStore:", forControlEvents: .TouchUpInside)
            recommendedStores.append(button)
            self.view.addSubview(button)
            
        }
        /*
        var anotherButton = UIButton(frame: CGRectMake(150, 100, 100, 100))
        anotherButton.backgroundColor = UIColor.blueColor()
        anotherButton.addTarget(self, action: "showStore:", forControlEvents: .TouchUpInside)
        //anotherButton.hitTest(<#point: CGPoint#>, withEvent: <#UIEvent?#>)
        self.view.addSubview(anotherButton)
    

        
        let imageView = UIImageView(frame: (CGRectMake(100, 100, mainScreenWidth/3, mainScreenWidth/3)))
        imageView.image = UIImage(named:"randomcat1.png")
        imageView.userInteractionEnabled = true
        var tap = UITapGestureRecognizer(target: self, action: "showStore:")
        //imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "showStore"))
        imageView.addGestureRecognizer(tap)
        recommendedStores.append(imageView)
        self.view.addSubview(imageView)
*/
    }
    
    func showStore(sender: UIButton!) {
        
        println("\(sender.tag) tapped")
        selectedStoreIndex = sender.tag
        performSegueWithIdentifier("ShowUserStoreHomePageSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("herer")
      //  println(segue.isKindOfClass(UIStoryboardEmbedSegue))
        if segue.destinationViewController.isKindOfClass(UserStoreHomePageViewController) {
            if segue.identifier == "ShowUserStoreHomePageSegue" {
                var storeViewController: UserStoreHomePageViewController = segue.destinationViewController as UserStoreHomePageViewController
                storeViewController.userIdForThisStore = 1
                storeViewController.storeId = selectedStoreIndex
            }
        }
        /*
        if segue.identifier == "NewItemForSellSegue" {
            var newItemForSellViewController: NewItemForSellViewController = segue.destinationViewController as NewItemForSellViewController
            //newItemForSellViewController.delegate = self
        }
*/
    }
}

