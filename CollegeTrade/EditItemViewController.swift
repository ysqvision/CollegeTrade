//
//  EditItemViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/30/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {
    @IBOutlet var itemName: UITextField!
    
    @IBOutlet var itemDescription: UITextView!
    @IBOutlet var itemPrice: UITextField!
    
    @IBOutlet var itemQuantity: UITextField!
    
    var itemToEdit: NSDictionary!
    
    var goodsID: Int!
   
    @IBAction func updateItemInformation(sender: AnyObject) {
        var price = itemPrice.text as NSString
        if (itemName.text == "" || itemDescription == "" || itemPrice.text == "" || itemQuantity.text == "") {
            var myAlert = UIAlertView(title: "信息不能为空",
                message: "请填写必要信息。",
                delegate: nil, cancelButtonTitle: "返回")
            myAlert.show()
        } else if (price.doubleValue <= 0.0) {
            var myAlert = UIAlertView(title: "价格错误",
                message: "价格必须要大于0。",
                delegate: nil, cancelButtonTitle: "返回")
            myAlert.show()
        }
        else if (itemQuantity.text.toInt() <= 0) {
            var myAlert = UIAlertView(title: "库存错误",
                message: "库存必须要大于0。",
                delegate: nil, cancelButtonTitle: "返回")
            myAlert.show()
        } else {
            var keyObject = [String: String]()
     
            DataBaseAPIHelper.updateItem(goodsID, name: itemName.text, description: itemDescription.text, quantity: itemQuantity.text, price: itemPrice.text ) { (success: Bool) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        var myAlert = UIAlertView(title: "更新成功",
                            message: "物品新信息发表成功！",
                            delegate: self, cancelButtonTitle: "确认")
                        myAlert.show()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else {
                        
                        var myAlert = UIAlertView(title: "更新失败",
                            message: "无法更新物品， 请稍后再试",
                            delegate: nil, cancelButtonTitle: "取消")
                        myAlert.show()
                    }
                })
            }
            
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var title = itemToEdit["goodsName"] as NSString
        var price = itemToEdit["price"] as Double
        var quantity = itemToEdit["quantity"] as Int
        var description = itemToEdit["goodsDescription"] as String
        
        itemName.text = title
        itemDescription.text = description
        itemPrice.text = "\(price)"
        itemQuantity.text = "\(quantity)"

    }
}
