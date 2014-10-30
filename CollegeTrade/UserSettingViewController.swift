//
//  UserSettingViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14-10-13.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserSettingViewController : UIViewController {

    @IBOutlet weak var settingTable: UITableView!
    
    @IBOutlet weak var settingTableView: UITableView!
    var n: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      //  n = 3
    }
    
    func newMessage(sender: UISwitch)
    {
        n = 4 - n
        settingTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return n}
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        var cell1: SwitchCell
        
        print(indexPath.row)

        
        switch indexPath.row{
        case 0:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "接受新消息通知"
            cell1.switchButton.addTarget(self, action: "newMessage:", forControlEvents:UIControlEvents.ValueChanged)
            return cell1
            
        case 1:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "声音"
            return cell1
            
        case 2:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "震动"
            return cell1
            
        case 3:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "新消息通知"
            return cell1
         
            
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("SettingCell1") as UITableViewCell
            
            cell.textLabel?.text = "杨手指"
            cell.detailTextLabel?.text = "杨少卿"
        }
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowUserStoreSegue" {
            println("herer2")
            var storeViewController: UserStoreHomePageViewController = segue.destinationViewController as UserStoreHomePageViewController
            storeViewController.userIdForThisStore = 1
            storeViewController.storeId = LOGGED_IN_USER_INFORMATION!["userId"] as? Int
        }
    }
    
}