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
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func table(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func table(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.table.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = "杨少卿"
        
        return cell
    }
    
    func table(table: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("You selected cell #\(indexPath.row)!")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}