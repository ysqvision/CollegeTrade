//
//  UserDetailedInformationViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/31/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation


class UserDetailedInformationViewController: UITableViewController, selectedPictureDelegate {
    @IBOutlet var userImage: UIImageView!
    var isUserImage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        var numberOfRows = self.tableView.numberOfRowsInSection(0)
        var userNameCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as UITableViewCell?
        var nickNameCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as UITableViewCell?
        var pointCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as UITableViewCell?
      //  var storeNameCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0)) as UITableViewCell?

        var userName = LOGGED_IN_USER_INFORMATION!["userName"] as NSString
        println(LOGGED_IN_USER_INFORMATION)
        userNameCell!.detailTextLabel?.text = userName
        nickNameCell!.detailTextLabel?.text = LOGGED_IN_USER_INFORMATION!["nickName"] as NSString
        pointCell!.detailTextLabel?.text = "\(LOGGED_IN_USER_POINT)"
        
        var userImageCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as UITableViewCell?
        var xLocation = userImageCell?.bounds.width
        var userImageButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        userImageButton.frame = CGRect(x: xLocation! - 160 ,y: 10,width: 150,height: 80)
        userImageButton.tag = 0
        userImageButton.addTarget(self, action: "addImage:", forControlEvents: .TouchUpInside)
        if LOGGED_IN_USER_IMAGE == nil {
            userImageButton.setImage(UIImage(named: "randomcat1.png"), forState: UIControlState.Normal)
            println("reached here sdfsdfsdf \(LOGGED_IN_USER_IMAGE)")
        } else {
            //println("reached here sdfsdfsdf \(LOGGED_IN_USER_IMAGE)")
            userImageButton.setImage(LOGGED_IN_USER_IMAGE, forState: UIControlState.Normal)
        }
        userImageCell?.addSubview(userImageButton)
        /*
        
        var storeImageCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 5, inSection: 0)) as UITableViewCell?

        var storeImageButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        storeImageButton.frame = CGRect(x: xLocation! - 160 ,y: 10,width: 150,height: 80)
        storeImageButton.tag = 1
        storeImageButton.addTarget(self, action: "addImage:", forControlEvents: .TouchUpInside)
        if LOGGED_IN_USER_STORE_IMAGE == nil {
            storeImageButton.setImage(UIImage(named: "randomcat1.png"), forState: UIControlState.Normal)
            
        }
        else {
            storeImageButton.setImage(LOGGED_IN_USER_STORE_IMAGE, forState: UIControlState.Normal)
        }
        storeImageCell?.addSubview(userImageButton)
        */
        
    }
    
    func addImage(sender: UIButton) {
        if sender.tag == 0 {
            isUserImage = true
        } else {
            isUserImage = false
        }
        let popoverVC = self.storyboard?.instantiateViewControllerWithIdentifier("TakePhotoViewController") as TakePhotoViewController
        popoverVC.delegate = self
        popoverVC.modalPresentationStyle = .OverFullScreen
        let popoverController = popoverVC.popoverPresentationController
        //     popoverController?.sourceView = sender as UIView
        //   popoverController?.sourceRect = sender.bounds
        presentViewController(popoverVC, animated: true, completion: nil)
    }
    
    func selectedPicture(value: UIImage) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var currentTime :Int = Int(NSDate().timeIntervalSince1970 * 1000)
        if isUserImage {
            LOGGED_IN_USER_IMAGE = value
        } else {
            LOGGED_IN_USER_STORE_IMAGE = value
        }
        var imagePath = "http://spiriiit-sharejx.b0.upaiyun.com/test/\(currentTime).jpg"
        
        var data = ["userImage=\(imagePath)"]
        
        var imagePathForUpyun = "\(currentTime).jpg"
        if isUserImage {
        DataBaseAPIHelper.editUser(LOGGED_IN_USER_INFORMATION!["userId"] as Int, data: data) { (success: Bool) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {
                    var myAlert = UIAlertView(title: "上传成功",
                        message: "新物品发表成功！",
                        delegate: self, cancelButtonTitle: "确认")
                    myAlert.show()
                    // upload images
                    
                        UpYunHelper.postPicture(value, fileName: imagePathForUpyun) { (success: Bool, url: String) -> () in
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                if (success) {
                                    
                                } else {
                                    var myAlert = UIAlertView(title: "失败",
                                        message: "上传图片失败， 请稍后再试",
                                        delegate: nil, cancelButtonTitle: "取消")
                                    myAlert.show()
                                }
                                
                            })
                        }
                    
                }
                else {
                    
                    var myAlert = UIAlertView(title: "失败",
                        message: "上传图片失败， 请稍后再试",
                        delegate: nil, cancelButtonTitle: "取消")
                    myAlert.show()
                }
            })
        }
        }
        self.tableView.reloadData()
        
    }
    
}