//
//  SignUpViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBAction func signup(sender: AnyObject) {
        var username = usernameTextField.text
        var password = passwordTextField.text
        var rpassword = repeatPasswordTextField.text
        var samepass = (password == rpassword)
        var pass = true
        
        //print(samepass);
        if (!samepass)
        {
            let myAlert = UIAlertView(title: "错误",
                message: "两次输入的密码不一致",
                delegate: nil, cancelButtonTitle: "重新输入")
            myAlert.show()
            
            usernameTextField.text = "";
            passwordTextField.text = "";
            repeatPasswordTextField.text = "";
        }
        else if pass {
            
            performSegueWithIdentifier("SignupSuccessful", sender: self)
            
        }
        else {
            let myAlert = UIAlertView(title: "错误",
                message: "用户名已经注册",
                delegate: nil, cancelButtonTitle: "重新输入")
            myAlert.show()
            
            usernameTextField.text = "";
            passwordTextField.text = "";
            repeatPasswordTextField.text = "";
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
