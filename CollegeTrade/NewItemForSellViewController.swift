//
//  NewItemForSellViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation


protocol postNewItemProtocol {
    func didPostNewItem()
}

class NewItemForSellViewController: UIViewController, selectedPictureDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    
    var delegate: postNewItemProtocol!
    
    var imageSet = [UIImage]()
    var imagePathSet = [String]()
    var imagePathSetForUpyun = [String]()
    
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet var imageTable: UITableView!
    
    @IBOutlet var itemDescription: UITextView!
    
    @IBOutlet var itemQuantity: UITextField!
    @IBOutlet var itemPrice: UITextField!
    
    @IBAction func chooseImage(sender: AnyObject) {
        let popoverVC = self.storyboard?.instantiateViewControllerWithIdentifier("TakePhotoViewController") as TakePhotoViewController
        popoverVC.delegate = self
        popoverVC.modalPresentationStyle = .OverFullScreen
        let popoverController = popoverVC.popoverPresentationController
        //     popoverController?.sourceView = sender as UIView
        //   popoverController?.sourceRect = sender.bounds
        presentViewController(popoverVC, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postItem(sender: AnyObject) {
        var name = self.itemName.text
        var description = self.itemDescription.text
        var price = self.itemPrice.text as NSString
        var quantity = self.itemQuantity.text
        
        if (name == "" || description == "" || price == "" || quantity == "") {
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
        else if (quantity.toInt() <= 0) {
            var myAlert = UIAlertView(title: "库存错误",
                message: "库存必须要大于0。",
                delegate: nil, cancelButtonTitle: "返回")
            myAlert.show()
        } else {
            
            DataBaseAPIHelper.postItem(name, description: description, images: imagePathSet, price: price, quantity: quantity) { (success: Bool) -> () in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        var myAlert = UIAlertView(title: "上传成功",
                            message: "新物品发表成功！",
                            delegate: self, cancelButtonTitle: "确认")
                        myAlert.show()
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                        // upload images
                        for index in 0...self.imageSet.count - 1 {
                            UpYunHelper.postPicture(self.imageSet[index], fileName: self.imagePathSetForUpyun[index]) { (success: Bool, url: String) -> () in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    if (success) {
                                        
                                    } else {
                                        var myAlert = UIAlertView(title: "上传图片",
                                            message: "图片\(index)失败， 请稍后再试",
                                            delegate: nil, cancelButtonTitle: "取消")
                                        myAlert.show()
                                    }
                                    
                                })
                            }
                        }
                    }
                    else {
                        
                        var myAlert = UIAlertView(title: "发表失败",
                            message: "无法发表物品， 请稍后再试",
                            delegate: nil, cancelButtonTitle: "取消")
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func selectedPicture(value: UIImage) {
        dismissViewControllerAnimated(true, completion: nil)
        var count = imageSet.count
        if count < 5 {
            var currentTime :Int = Int(NSDate().timeIntervalSince1970 * 1000)
            imageSet.append(value)
            imagePathSet.append("\(UPYUN_PUBLIC_DOMAIN)\(UPYUN_BUCKET)\(currentTime).jpg")
            imagePathSetForUpyun.append("\(currentTime).jpg")
        }
        
        self.imageTable.reloadData()
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("selectedImageToUpload") as UITableViewCell
    
        cell.imageView?.image = imageSet[indexPath.row]
        return cell

    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
       self.navigationController?.popViewControllerAnimated(true)
    }

}