//
//  NewOrderViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/29/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet var quantity: UITextField!
    @IBOutlet var deliveryAddress: UITextView!
    @IBOutlet var telephoneNumber: UITextField!
    @IBOutlet var buyerName: UITextField!
    
    @IBAction func confirmToBuy(sender: AnyObject) {
        if buyerName.text == "" {
            var myAlert = UIAlertView(title: "错误",
                message: "收件人姓名不能为空。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
        } else if telephoneNumber == "" {
            var myAlert = UIAlertView(title: "错误",
                message: "请提供电话号码。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )

        } else if deliveryAddress.text == "" {
            var myAlert = UIAlertView(title: "错误",
                message: "收件人地址不能为空。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
        } else if quantity.text.toInt() <= 0 {
                      var myAlert = UIAlertView(title: "错误",
                message: "购买数量要大于0.",
                delegate: nil,
                cancelButtonTitle: "取消"
            )

        } else {
            var myAlert = UIAlertView(title: "确认购买",
                message: "您确定要购买吗。",
                delegate: self,
                cancelButtonTitle: "取消",
                otherButtonTitles: "确认"
            )
        
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex {
            
        } else {
            OrderAPIHelper.addOrder("userid", userSession: "session", goodId: "goodId", address: deliveryAddress.text, phone: telephoneNumber.text, name: buyerName.text, quantity: quantity.text.toInt()!){ (success: Bool) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        var myAlert = UIAlertView(title: "成功",
                            message: "添加订单成功",
                            delegate: nil, cancelButtonTitle: "确认")
                        myAlert.show()
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    } else {
                        
                        var myAlert = UIAlertView(title: "错误",
                            message: "添加订单失败！ 请稍后再试。",
                            delegate: nil, cancelButtonTitle: "取消")
                        myAlert.show()
                    }
                })
            }
        }
    }
}
