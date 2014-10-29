//
//  FriendListViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//
import UIKit

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didGetFriendListProtocol {
    var friendName = [String]()
    
    var searchFriendListAPI = SearchForFriendList()
    
    @IBOutlet var friendListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFriendListAPI.delegate = self
        searchFriendListAPI.getFriendList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendName.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as UITableViewCell
        cell.textLabel?.text = friendName[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ChatWithFriend") {
            var chatWithFriendViewController: ChatWithFriendViewController = segue.destinationViewController as ChatWithFriendViewController
            var index = friendListTable.indexPathForSelectedRow()!.row;
            var selectedFriend = self.friendName[index]
           chatWithFriendViewController.friendName = selectedFriend
        }
        
    }

    
    func didGetFriendList(value: [String]) {
        dispatch_async(dispatch_get_main_queue(), {
            self.friendName = value
            self.friendListTable!.reloadData()
        })
    }
}