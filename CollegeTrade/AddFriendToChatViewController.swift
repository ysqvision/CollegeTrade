//
//  AddFriendToChatViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/29/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class AddFriendToChatViewController: UIViewController {
    @IBOutlet var username: UITextField!
    
    
    @IBAction func addFriend(sender: AnyObject) {
        if username.text == "" {
            var myAlert = UIAlertView(title: "用户名错误",
                message: "用户名不能为空",
                delegate: nil, cancelButtonTitle: "重新输入")
            myAlert.show()
        } else {
            var result = EaseMob.sharedInstance().chatManager.addBuddy(username.text, message: "", error: nil)
            if result {
                var myAlert = UIAlertView(title: "发送成功",
                    message: "添加好友信息已发送",
                    delegate: nil, cancelButtonTitle: "确定")
                myAlert.show()
            } else {
                var myAlert = UIAlertView(title: "发送失败",
                    message: "请确认您填写了正确的用户名",
                    delegate: nil, cancelButtonTitle: "重新输入")
                myAlert.show()

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
