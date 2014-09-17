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
    @IBAction func validateLoginCredentials(sender: AnyObject) {
        var username = usernameTextField.text
        var password = passwordTextField.text
        var pass = checkLoginCredential(username, password: password)
        if pass {
            performSegueWithIdentifier("LoginSuccessful", sender: self)
        }
        else {
            let myAlert = UIAlertView(title: "非法登陆",
                message: "请输入正确的用户名和密码",
                delegate: nil, cancelButtonTitle: "重新输入")
            myAlert.show()
        }
    }
    
    func checkLoginCredential(username: String, password: String) -> Bool {
        // Check if username and password pass
        if username == "victor" && password == "pass" {
            return true;
        } else {
            return false;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.secureTextEntry = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

