//
//  TakePhotoViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/14/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//
import UIKit

class TakePhotoViewController : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate: writeValueBackDelegate?
    
    @IBAction func pickPhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        delegate?.writeValueBack(image.description)
        println("i've got an image");
    }
    
}