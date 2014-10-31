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
    
    var goodsId: Int!
    
    var goodsPrice: Double!
    
    @IBAction func confirmOrder(sender: AnyObject) {
        println("here")
        println(buyerName.text)
        if buyerName.text == "" {
            println("dkfjssd")
            var myAlert = UIAlertView(title: "错误",
                message: "收件人姓名不能为空。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
             myAlert.show()
        } else if telephoneNumber == "" {
            var myAlert = UIAlertView(title: "错误",
                message: "请提供电话号码。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
             myAlert.show()
            
        } else if deliveryAddress.text == "" {
            var myAlert = UIAlertView(title: "错误",
                message: "收件人地址不能为空。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
            myAlert.show()
        } else if quantity.text.toInt() <= 0 {
            var myAlert = UIAlertView(title: "错误",
                message: "购买数量要大于0.",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
             myAlert.show()
            
        } else if LOGGED_IN_USER_POINT! < 5 {
            var myAlert = UIAlertView(title: "交易失败",
                message: "您的信用额度已不够完成此次交易。",
                delegate: nil,
                cancelButtonTitle: "取消"
            )
            myAlert.show()
        }
        else {
            var myAlert = UIAlertView(title: "确认购买",
                message: "您确定要购买吗， 将会暂时扣除信用额度5分，交易成功后返还。",
                delegate: self,
                cancelButtonTitle: "取消",
                otherButtonTitles: "确认"
            )
            myAlert.show()
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        println("here")
        if buttonIndex == alertView.cancelButtonIndex {
            
        } else {
            DataBaseAPIHelper.buyItem("\(goodsId)", address: deliveryAddress.text, phone: telephoneNumber.text, goodsPrice: "\(goodsPrice)"){ (success: Bool) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        var myAlert = UIAlertView(title: "成功",
                            message: "添加订单成功",
                            delegate: nil, cancelButtonTitle: "确认")
                        myAlert.show()
                        LOGGED_IN_USER_POINT = LOGGED_IN_USER_POINT! - 5
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
