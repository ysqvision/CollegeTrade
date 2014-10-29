//
//  FriendListAPIController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

protocol didGetFriendListProtocol {
    func didGetFriendList(value : [String])
}

class SearchForFriendList {
    var delegate: didGetFriendListProtocol?
    init() {
    }
    func getFriendList() {
        var buddys = EaseMob.sharedInstance().chatManager.buddyList as [EMBuddy]
        
        var usernames = [String]()
        for buddy in buddys {
            if (!buddy.isPendingApproval) {
                usernames.append(buddy.username)
            }
        }
        self.delegate?.didGetFriendList(usernames)
    

    }
}