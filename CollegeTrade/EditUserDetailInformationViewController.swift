//
//  EditUserDetailInformationViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/31/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

protocol EditUserDetailInformationProtocol {
    func didModifyInformation(field:String!, value: String!)
}

class EditUserDetailInformationViewController: UIViewController {
    
    var field: String?
    var originalValue: String?
    
    var delegate: EditUserDetailInformationProtocol?
    
    @IBOutlet var textField: UITextField!
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func confirmUpdate(sender: AnyObject) {
        var data = ["\(field!)=\(textField.text)"]
        DataBaseAPIHelper.editUser(LOGGED_IN_USER_INFORMATION!["userId"] as Int, data: data) { (success: Bool) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {
                    var myAlert = UIAlertView(title: "成功",
                        message: "更新信息成功！",
                        delegate: self, cancelButtonTitle: "确认")
                    myAlert.show()
                    
                }
                else {
                    
                    var myAlert = UIAlertView(title: "失败",
                        message: "更新信息失败， 请稍后再试",
                        delegate: nil, cancelButtonTitle: "取消")
                    myAlert.show()
                }
            })
        }

        if (field == "phoneNumber") {
            LOGGED_IN_USER_PHONE = textField.text.toInt()
        }
        if (field == "nickName") {
            LOGGED_IN_USER_NICKNAME = textField.text
        }
        if (field == "userAddress") {
            LOGGED_IN_USER_ADDRESS = textField.text
        }
        delegate?.didModifyInformation(field!, value: textField.text)
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet var confirmUpdat: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if field == "phoneNumber" {
            textField.keyboardType = UIKeyboardType.NumberPad
        }
    }
}
