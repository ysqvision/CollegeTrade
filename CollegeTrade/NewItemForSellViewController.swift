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

class NewItemForSellViewController: UIViewController, selectedPictureDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: postNewItemProtocol!
    
    var imageSet = [UIImage]()
    var imagePathSet = [String]()
    var imagePathSetForUpyun = [String]()
    
    @IBOutlet var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet var imageTable: UITableView!
    
    @IBOutlet var itemDescription: UITextView!
    
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
        
        
        DataBaseAPIHelper.postItem(name, description: description, images: imagePathSet) { (success: Bool) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {
                    
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



        /*
        var currentTime = NSDate().timeIntervalSince1970 * 1000
        var imagePath = ["\(UPYUN_PUBLICK_DOMAIN)\(currentTime).jpg"]
        UpYunHelper.postPicture(self.itemImage.image!, fileName: "\(currentTime).jpg") { (success: Bool, url: String) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (success) {
                    var name = self.itemName.text
                    var description = self.itemDescription.text
                    
                    DataBaseAPIHelper.postItem(name, description: description, images: imagePath) { (success: Bool) -> () in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if success {
                                
                                self.dismissViewControllerAnimated(true, completion: nil)
                                
                            } else {
                                
                                var myAlert = UIAlertView(title: "发表失败",
                                    message: "无法发表物品， 请稍后再试",
                                    delegate: nil, cancelButtonTitle: "取消")
                                myAlert.show()
                            }
                        })
                    }
                } else {
                    var myAlert = UIAlertView(title: "发表失败",
                        message: "上传图片失败， 请稍后再试",
                        delegate: nil, cancelButtonTitle: "取消")
                    myAlert.show()
                }
                
            })
        }
*/
 
    
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
        var currentTime :Int = Int(NSDate().timeIntervalSince1970 * 1000)
        imageSet.append(value)
        imagePathSet.append("http://spiriiit-sharejx.b0.upaiyun.com/test/\(currentTime).jpg")
        imagePathSetForUpyun.append("\(currentTime).jpg")
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

}