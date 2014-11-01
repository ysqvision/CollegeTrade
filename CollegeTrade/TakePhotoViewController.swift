//
//  TakePhotoViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/14/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//
import UIKit
import MobileCoreServices


protocol selectedPictureDelegate {
    func selectedPicture(value: UIImage)
}

class TakePhotoViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate: selectedPictureDelegate?
    
    var _newPhoto = false
    @IBAction func pickPhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
        _newPhoto = false
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            _newPhoto = true
        } else {
            var myAlert = UIAlertView(title: "没有检测到相机",
                message: "在设备里没有检测到相机！",
                delegate: nil, cancelButtonTitle: "取消")
            myAlert.show()
        }
    }
    
    @IBAction func cancelPopover(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary)
    {
        //var mediaType:NSString = info.objectForKey(UIImagePickerControllerEditedImage) as NSString
        var imageToSave:UIImage
        
        imageToSave = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        delegate?.selectedPicture(imageToSave)
        if (_newPhoto) {
            UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}