//
//  OrderDetailViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/29/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController, UIAlertViewDelegate {
    //@IBOutlet var userId: UILabel!
    @IBOutlet var cellNumber: UILabel!
    @IBOutlet var receiverName: UILabel!
    @IBOutlet var receiverAddress: UITextView!
    
    @IBOutlet var completeButton: UIButton!
    
    var order: NSDictionary?
    
    @IBAction func orderAction(sender: AnyObject) {
        if isBuyOrder {
            var myAlert = UIAlertView(title: "取消订单",
                message: "您确定要取消订单吗？信用积分将不会返还。",
                delegate: self,
                cancelButtonTitle: "取消",
                otherButtonTitles: "确认"
            )
            myAlert.show()
        } else {
            var myAlert = UIAlertView(title: "完成订单",
                message: "您确定要完成订单吗？信用积分将返还给买方。",
                delegate: self,
                cancelButtonTitle: "取消",
                otherButtonTitles: "确认"
            )
            myAlert.show()
        }
    }
    
    var isBuyOrder = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // var id = order!["userId"] as Int
       // userId.text = "\(id)"
        
        receiverName.text = order!["buyerName"] as String
        
        var number = order!["phone"] as Int
        
        cellNumber.text = "\(number)"
        
        receiverAddress.userInteractionEnabled = true
        receiverAddress.scrollEnabled = true
        receiverAddress.editable = false
        receiverAddress.text = order!["adress"] as String
        
        if isBuyOrder {
            completeButton.setTitle("取消订单", forState: UIControlState.Normal)
        } else {
            completeButton.setTitle("完成订单", forState: UIControlState.Normal)
        }
        receiverAddress.userInteractionEnabled = true
        receiverAddress.scrollEnabled = true
        receiverAddress.editable = false
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex {
            
        } else {
            if isBuyOrder {
                // update order
                var orderId = order!["buyGoodsId"] as Int
                OrderAPIHelper.cancelOrder("0", orderId: orderId){ (success: Bool) -> () in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if success {
                            var myAlert = UIAlertView(title: "成功",
                                message: "取消订单成功， 信用积分将不会返还。",
                                delegate: nil, cancelButtonTitle: "确认")
                            myAlert.show()
                            self.navigationController?.popViewControllerAnimated(true)
                            
                        } else {
                            
                            var myAlert = UIAlertView(title: "错误",
                                message: "取消订单失败！ 请稍后再试。",
                                delegate: nil, cancelButtonTitle: "取消")
                            myAlert.show()
                        }
                    })
                }

            } else {
                var orderId = order!["buyGoodsId"] as Int
                OrderAPIHelper.completeOrder("0", orderId: orderId){ (success: Bool) -> () in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if success {
                            var myAlert = UIAlertView(title: "成功",
                                message: "完成订单成功， 信用积分将返还给买家。",
                                delegate: nil, cancelButtonTitle: "确认")
                            myAlert.show()
                            
                            //var buyerId =
                            
                            self.navigationController?.popViewControllerAnimated(true)
                            
                        } else {
                            
                            var myAlert = UIAlertView(title: "错误",
                                message: "完成订单失败！ 请稍后再试。",
                                delegate: nil, cancelButtonTitle: "取消")
                            myAlert.show()
                        }
                    })
                }
            }
        }
    }
}
