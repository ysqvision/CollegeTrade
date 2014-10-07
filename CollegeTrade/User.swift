//
//  User.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/6/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

class User {
    var name: String
    var id: Int
    var stores = [Store]()
    
    init(name: String, id: Int, stores: [Store]) {
        self.name = name
        self.id = id
        self.stores = stores
    }
}
