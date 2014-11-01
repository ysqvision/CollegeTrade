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
        else {
            DataBaseAPIHelper.userSignUp(username, password: password) { (status: Int) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if status == 1 {
                        var myAlert = UIAlertView(title: "注册成功！",
                            message: "恭喜您注册成功！",
                            delegate: nil, cancelButtonTitle: "取消")
                        myAlert.show()
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                    } else if status == 2 {
                        var myAlert = UIAlertView(title: "注册失败！",
                            message: "用户名已存在！",
                            delegate: nil, cancelButtonTitle: "取消")
                        myAlert.show()
                        
                    }
                    else {
                        
                        var myAlert = UIAlertView(title: "注册失败！",
                            message: "注册失败！",
                            delegate: nil, cancelButtonTitle: "重新注册")
                        myAlert.show()
                    }
                })
            }
            
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
