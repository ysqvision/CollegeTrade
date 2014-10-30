//
//  ItemForSell.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/6/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

class ItemForSell {
    var title: String
    var price: Double
    var description: String
    var imageUrl: [String]
    
    init(title: String, price: Double, description: String, imageUrl: [String]) {
        self.title = title;
        self.price = price;
        self.description = description
        self.imageUrl = imageUrl
    }
}