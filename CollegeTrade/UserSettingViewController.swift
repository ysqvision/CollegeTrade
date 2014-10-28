//
//  UserSettingViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14-10-13.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserSettingViewController : UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    @IBAction func goBackFromUserSetting(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        var cell1: SwitchCell

        
        switch indexPath.row{
        case 0:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "接受新消息通知"
            return cell1
            
        case 1:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "声音"
            return cell1
            
        case 2:
            cell1 = tableView.dequeueReusableCellWithIdentifier("SettingCell4") as SwitchCell
            cell1.titleLabel.text = "声音"
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
    
    
}