//
//  ItemDetailViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//


import UIKit

class ItemDetailViewController: UIViewController {
    
    //@IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var itemPic: UIImageView!
    var item: ItemForSell!
    var commentNum: Int!
    
    @IBOutlet weak var commentTable: UITableView!
    
    @IBAction func add(sender: AnyObject) {
        
        let indexPathh = NSIndexPath(forRow: commentNum + 1, inSection: 0)
        commentNum = commentNum + 1
        //commentTable.insertRowsAtIndexPaths([indexPathh], withRowAnimation: .Automatic)
        commentTable.reloadData()
        //commentTable.frame = CGRectMake(CGFloat(8),CGFloat(8),CGFloat(100),CGFloat(50*commentNum))
        //moreButton.frame = CGRectMake(CGFloat(8),CGFloat(8 + 50*commentNum),CGFloat(300), CGFloat(50))
        
    }
    
    @IBOutlet weak var itemName: UILabel!
    
    
    @IBOutlet weak var itemPrice: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            itemName.text = "名称： \(self.item.title)"
            itemPrice.text = "价格： \(self.item.price)"
            
            commentNum = 4
            
            itemPic.image = UIImage(named:"randomcat1.png")
            
            var pagedImageScrollView: PagedImageScrollView = PagedImageScrollView(frame: CGRect(x:0, y:0, width: 320,height: 120))
            pagedImageScrollView.setScrollViewContents(["randomcat1.png", "randomcat1.png"])
            self.view.addSubview(pagedImageScrollView)
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //  Comment Table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentNum
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        if (indexPath.row < tableView.numberOfRowsInSection(0) - 1)
        {
            cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as UITableViewCell
            
            cell.textLabel?.text = "Comment No.\(indexPath.row + 1) :"
            cell.detailTextLabel?.text = "杨少卿的手指非常的好用"
            cell.imageView?.image = UIImage(named: "randomcat1.png")
        
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("MoreCell") as UITableViewCell
            
            cell.textLabel?.text = "更多评论"
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if (indexPath.row == tableView.numberOfRowsInSection(0) - 1)
        {
            commentNum = commentNum + 3
            tableView.reloadData()
           // tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
           // tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
