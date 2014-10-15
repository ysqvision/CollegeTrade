//
//  UserSettingViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14-10-13.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserSettingViewController : UIViewController {
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
        print(indexPath.row)
        
        switch indexPath.row{
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("SettingCell1") as UITableViewCell
        
            cell.textLabel?.text = "杨手指"
            cell.detailTextLabel?.text = "杨少卿"
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("SettingCell2") as UITableViewCell
            
            cell.textLabel?.text = "杨手指"
            cell.detailTextLabel?.text = "杨少卿"
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("SettingCell3") as UITableViewCell
            
            cell.textLabel?.text = "杨手指"
            cell.detailTextLabel?.text = "杨少卿"
            
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