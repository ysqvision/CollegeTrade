//
//  ItemDetailViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//


import UIKit

class ItemDetailViewController: UIViewController {
    
    var item: ItemForSell!
    var commentNum: Int!
    
    @IBOutlet weak var commentTable: UITableView!
    
    @IBAction func add(sender: AnyObject) {
        
        let indexPathh = NSIndexPath(forRow: commentNum + 1, inSection: 0)
        commentNum = commentNum + 1
        commentTable.insertRowsAtIndexPaths([indexPathh], withRowAnimation: .Automatic)
    }
    
    @IBOutlet weak var itemName: UILabel!
    
    
    @IBOutlet weak var itemPrice: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            itemName.text = "名称： \(self.item.title)"
            itemPrice.text = "价格： \(self.item.price)"
            
            commentNum = 3
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //  Comment Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentNum + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
        if (indexPath.row < tableView.numberOfRowsInSection(0) - 1)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as UITableViewCell
            
            cell.textLabel?.text = "Comment No.\(indexPath.row + 1) :"
            cell.detailTextLabel?.text = "杨少卿的手指非常的好用"
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("AdditionCell") as UITableViewCell
            cell.textLabel?.text = "更多评论"
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        if (indexPath.row == tableView.numberOfRowsInSection(0) - 1)
        {
            print(commentNum)
            let indexPathh = NSIndexPath(forRow: commentNum, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPathh], withRowAnimation: .Automatic)
            commentNum = commentNum + 1
           // tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
           // tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
