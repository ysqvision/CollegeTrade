//
//  FriendRequestViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/29/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

protocol friendRequestProtocol {
    func clearNumOfNewRequest()
    func removeBuddyRequest(username: String)
}

class FriendRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var friendRequestList = [String]()
    
    var delegate: friendRequestProtocol!
    
    @IBOutlet var requestTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate.clearNumOfNewRequest()
        requestTable.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendRequestList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendRequestCell") as UITableViewCell
        cell.textLabel?.text = "\(friendRequestList[indexPath.row]) 想加你为好友"
        var yesButton:UIButton = UIButton(frame: CGRectMake(cell.frame.origin.x + 150, cell.frame.origin.y, 40, 30))
        var noButton:UIButton = UIButton(frame: CGRectMake(cell.frame.origin.x + 200, cell.frame.origin.y, 40, 30))
        yesButton.setTitle("同意", forState: UIControlState.Normal)
        noButton.setTitle("拒绝", forState: UIControlState.Normal)
        yesButton.tag = indexPath.row
        noButton.tag = indexPath.row
        yesButton.backgroundColor = UIColor.blueColor()
        noButton.backgroundColor = UIColor.blueColor()
        yesButton.addTarget(self, action: "confirmRequest:", forControlEvents: .TouchUpInside)
        noButton.addTarget(self, action: "disgardRequest:", forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(yesButton)
        cell.contentView.addSubview(noButton)
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func confirmRequest(sender: UIButton!) {
        var index = sender.tag
        var username = friendRequestList[index]
        EaseMob.sharedInstance().chatManager.acceptBuddyRequest(username, error: nil)
        friendRequestList.removeAtIndex(index)
        delegate.removeBuddyRequest(username)
    }
    
    func disgardRequest(sender: UIButton!) {
        var index = sender.tag
        var username = friendRequestList[index]
        EaseMob.sharedInstance().chatManager.rejectBuddyRequest(username, reason: "", error: nil)
        friendRequestList.removeAtIndex(index)
        delegate.removeBuddyRequest(username)
    }

}
