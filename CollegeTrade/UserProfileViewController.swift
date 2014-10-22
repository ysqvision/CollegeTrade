//
//  UserProfileViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14-10-6.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UIPopoverPresentationControllerDelegate, selectedPictureDelegate {
    
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var shopNameButton: UIButton!
    @IBOutlet weak var myItemButton: UIButton!
    @IBOutlet weak var boughtItemButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func takePhoto(sender: AnyObject) {
        let popoverVC = self.storyboard?.instantiateViewControllerWithIdentifier("TakePhotoViewController") as TakePhotoViewController
        popoverVC.delegate = self
        popoverVC.modalPresentationStyle = .OverFullScreen
        let popoverController = popoverVC.popoverPresentationController
        //     popoverController?.sourceView = sender as UIView
        //   popoverController?.sourceRect = sender.bounds
        presentViewController(popoverVC, animated: true, completion: nil)
    }


    
  
    @IBAction func userLogout(sender: AnyObject) {
        var storedUsername = KeychainService.loadToken("SPIRIIITCOLLEGETRADEUSERNAME")
        var storedPass = KeychainService.loadToken("SPIRIIITCOLLEGETRADEPASSWORD")
        KeychainService.removeToken("SPIRIIITCOLLEGETRADEUSERNAME", token: storedUsername!)
        KeychainService.removeToken("SPIRIIITCOLLEGETRADEPASSWORD", token: storedPass!)
        USER_IS_LOGGED_IN = false
        LOGGED_IN_USER_INFORMATION = nil
        self.tabBarController?.selectedIndex = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if USER_IS_LOGGED_IN == false {
            performSegueWithIdentifier("ShowLoginScreen", sender: self)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func selectedPicture(value: UIImage) {
        dismissViewControllerAnimated(true, completion: nil)
        self.profilePicture.image = value
    }
    
    
}
