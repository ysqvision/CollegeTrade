//
//  ViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBAction func validateLoginCredentials(sender: AnyObject) {
        var username = usernameTextField.text
        var password = passwordTextField.text
        DataBaseAPIHelper.checkLoginCredential(username, password: password) { (success: Bool) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {

                    USER_IS_LOGGED_IN = true
                    KeychainService.saveToken("SPIRIIITCOLLEGETRADEUSERNAME", token: username)
                    KeychainService.saveToken("SPIRIIITCOLLEGETRADEPASSWORD", token: password)
                    self.dismissViewControllerAnimated(true, completion: nil)

                } else {
                    
                    var myAlert = UIAlertView(title: "非法登陆",
                        message: "请输入正确的用户名和密码",
                        delegate: nil, cancelButtonTitle: "重新输入")
                    myAlert.show()
                }
            })
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.secureTextEntry = true
        // Do any additional setup after loading the view, typically from a nib.
        
        // setting button and labels' position, color and size
        let maojmBlue = UIColor(red:0.5, green:0.8,blue:1.0,alpha:1.0)
        let maojmSilver = UIColor(red:0.5, green:0.5,blue:0.5,alpha:1.0)
        
        loginButton.frame = CGRectMake(300,50,500,50)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        loginButton.setBackgroundImage(UIImage(named: "ButtonBlue.png"), forState: UIControlState.Normal)
        
        registerButton.backgroundColor = maojmBlue
        registerButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

