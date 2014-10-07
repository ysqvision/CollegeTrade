//
//  UserProfileViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14-10-6.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var shopNameButton: UIButton!
    @IBOutlet weak var myItemButton: UIButton!
    @IBOutlet weak var boughtItemButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileButton.layer.borderWidth = 1
        shopNameButton.layer.borderWidth = 1
        myItemButton.layer.borderWidth = 1
        boughtItemButton.layer.borderWidth = 1
        settingButton.layer.borderWidth = 1
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
