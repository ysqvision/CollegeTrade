//
//  Store.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/6/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

class Store {
    var items = [ItemForSell]()
    var name: String
    var activity: Int
    var reputation: Int
    var tranction: Int
    
    init(items: [ItemForSell], name: String, activity: Int, reputation: Int, transaction: Int) {
        self.items = items
        self.name = name
        self.activity = activity
        self.reputation = reputation
        self.tranction = transaction
    }
}