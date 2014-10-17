//
//  UserProfileViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14-10-6.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UIPopoverPresentationControllerDelegate, writeValueBackDelegate {
    
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var shopNameButton: UIButton!
    @IBOutlet weak var myItemButton: UIButton!
    @IBOutlet weak var boughtItemButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    
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
        var storedPass = KeychainService.loadToken("victor")
        KeychainService.removeToken("victor", token: storedPass!)
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
        var storedPass = KeychainService.loadToken("victor")
        if storedPass == "pass" {
            
        } else {
            performSegueWithIdentifier("ShowLoginScreen", sender: self)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func writeValueBack(value: String) {
        println(value)
    }
    
    
}
