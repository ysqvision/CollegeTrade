//
//  UserSettingTableViewController.swift
//  CollegeTrade
//
//  Created by Jieming Mao on 14/10/28.
//  Copyright (c) 2014年 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserSettingTableViewController: UITableViewController {
    @IBOutlet weak var logoutButton: UITableViewCell!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var x = indexPath.section
        print(x)
        if (x == 3)
        {
            var storedUsername = KeychainService.loadToken("SPIRIIITCOLLEGETRADEUSERNAME")
            var storedPass = KeychainService.loadToken("SPIRIIITCOLLEGETRADEPASSWORD")
            KeychainService.removeToken("SPIRIIITCOLLEGETRADEUSERNAME", token: storedUsername!)
            KeychainService.removeToken("SPIRIIITCOLLEGETRADEPASSWORD", token: storedPass!)
            USER_IS_LOGGED_IN = false
            LOGGED_IN_USER_INFORMATION = nil
            let storyBoard = UIStoryboard(name: "Main", bundle:nil)
            
            /*
            var uc: UserProfileViewController = storyBoard.instantiateViewControllerWithIdentifier("UserProfileViewController") as UserProfileViewController
            uc.tabBarController?.selectedIndex = 0
*/
            self.parentViewController?.tabBarController?.selectedIndex = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowUserStoreSegue" {
               println("herer1")
            var storeViewController: UserStoreHomePageViewController = segue.destinationViewController as UserStoreHomePageViewController
            storeViewController.userIdForThisStore = LOGGED_IN_USER_INFORMATION!["userId"] as? Int

            storeViewController.storeId = 1
        }
    }
    
}