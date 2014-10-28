//
//  NewItemForSellViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

class NewItemForSellViewController: UIViewController {
    
    
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet var itemDescription: UITextField!
    
    @IBAction func chooseImage(sender: AnyObject) {
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postItem(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view, typically from a nib.
    }
    
    

}