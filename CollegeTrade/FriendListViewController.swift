//
//  FriendListViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//
import UIKit

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didGetFriendListProtocol, chatProtocol, friendRequestProtocol {
    var friendName = [String]()
    var chatHistory = [String: [EMMessage]]()
    var conversation = [String: EMConversation]()
    var searchFriendListAPI = SearchForFriendList()
    
    var buddyRequest = [String]()
    
    var newFriendRequest = 0
    
    //var friendRequest
   
    @IBOutlet var friendListTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
       super.viewWillAppear(animated)
        searchFriendListAPI.delegate = self
        searchFriendListAPI.getFriendList()
        friendListTable.reloadData()
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendName.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as UITableViewCell
     
        if indexPath.row == 0 {
            cell.textLabel?.text = "处理好友申请"
            cell.detailTextLabel?.text = "\(newFriendRequest)条新好友请求"
        } else {
            var name = friendName[indexPath.row - 1]
            
            cell.textLabel?.text = name
            var conversationWithName = self.conversation[name]
            var numOfUnreadMessage: UInt = conversationWithName!.unreadMessagesCount() as UInt
            if numOfUnreadMessage != 0 {
                cell.detailTextLabel?.text = "\(numOfUnreadMessage)条未读消息"
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            performSegueWithIdentifier("ShowFriendRequestSegue", sender: nil)
        } else {
            performSegueWithIdentifier("ChatWithFriendSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChatWithFriendSegue" {
            var chatWithFriendViewController: ChatWithFriendViewController = segue.destinationViewController as ChatWithFriendViewController
            chatWithFriendViewController.delegate = self
            var index = friendListTable.indexPathForSelectedRow()!.row;

            var selectedFriend = self.friendName[index - 1]
            chatWithFriendViewController.friendName = selectedFriend
            chatWithFriendViewController.messages = self.chatHistory[selectedFriend]!
            self.conversation[selectedFriend]?.markMessagesAsRead(true)
            friendListTable.reloadData()
        } else if segue.identifier == "ShowFriendRequestSegue" {
            var friendRequestViewController: FriendRequestViewController = segue.destinationViewController as FriendRequestViewController
            friendRequestViewController.friendRequestList = buddyRequest
            friendRequestViewController.delegate = self
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
    
    func receivedBuddyRequest(username: String, message: String) {
        buddyRequest.append(username)
        newFriendRequest = newFriendRequest + 1
        friendListTable.reloadRowsAtIndexPaths([0], withRowAnimation: UITableViewRowAnimation.Fade)
    }

    func receivedMessage(message: EMMessage) {
        var exten = message.ext as [String: String]
        var username: String = exten["username"]! as String
        var conversation = EaseMob.sharedInstance().chatManager.conversationForChatter(username, isGroup: true)
        self.conversation[username] = conversation
        var messages: [EMMessage] = conversation.loadAllMessages() as [EMMessage]
        self.chatHistory[username] = messages
        friendListTable.reloadData()
    }
    
    func clearNumOfNewRequest() {
        newFriendRequest = 0
        friendListTable.reloadData()
    }
    
    func removeBuddyRequest(username: String) {
        var index = -1
        if buddyRequest.count == 0 {
            return
        }
        for i in 0...buddyRequest.count - 1 {
            if buddyRequest[i] == username {
                index = i
                break
            }
        }
        if index != -1 {
            buddyRequest.removeAtIndex(index)
        }
        
    }
    
}