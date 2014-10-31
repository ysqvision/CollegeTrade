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
   
    @IBAction func updateItemInformation(sender: AnyObject) {
        
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
