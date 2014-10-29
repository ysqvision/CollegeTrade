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
    var chatHistory = [String: [EMMessage]]()
    var conversation = [String: EMConversation]()
    var searchFriendListAPI = SearchForFriendList()
    
    @IBOutlet var friendListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let addFriendButton = UIBarButtonItem(title: "添加好友", style: UIBarButtonItemStyle.Bordered, target: self, action: "addFriend")
        self.navigationItem.rightBarButtonItem = addFriendButton
        searchFriendListAPI.delegate = self
        searchFriendListAPI.getFriendList()
    }
    
    @IBAction func addFriend(sender: AnyObject) {
        
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
        var name = friendName[indexPath.row]
        
        cell.textLabel?.text = name
        var conversationWithName = self.conversation[name]
        var numOfUnreadMessage: UInt = conversationWithName!.unreadMessagesCount() as UInt
        if numOfUnreadMessage != 0 {
            cell.detailTextLabel?.text = "\(numOfUnreadMessage)条未读消息"
        }
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
            chatWithFriendViewController.messages = self.chatHistory[selectedFriend]!
            self.conversation[selectedFriend]?.markMessagesAsRead(true)
        }
        
    }

    
    func didGetFriendList(value: [String]) {
        dispatch_async(dispatch_get_main_queue(), {
            self.friendName = value
            
            for name in self.friendName {
                var conversation: EMConversation = EaseMob.sharedInstance().chatManager.conversationForChatter(name, isGroup: true)
                self.conversation[name] = conversation
                var messages: [EMMessage] = conversation.loadAllMessages() as [EMMessage]
                self.chatHistory[name] = messages
                
            }
            self.friendListTable!.reloadData()
        })
        
    }
}