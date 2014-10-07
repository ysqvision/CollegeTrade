//
//  ItemDetailViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//


import UIKit

class ItemDetailViewController: UIViewController {
    
    var item: ItemForSell!
    
    @IBOutlet weak var itemName: UILabel!
    
    
    @IBOutlet weak var itemPrice: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            itemName.text = "名称： \(self.item.title)"
            itemPrice.text = "价格： \(self.item.price)"
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
