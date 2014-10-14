//
//  UserHomePageViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let kCellIdentifier: String = "ItemForSellCell"
    var itemsForSell = [ItemForSell]()
    
    @IBOutlet weak var transition: UIButton!
    @IBOutlet weak var itemsTable: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        var item1 = ItemForSell(title: "Nike", price: 500.0)
        var item2 = ItemForSell(title: "阿迪王", price: 300.0)
        itemsForSell.append(item1)
        itemsForSell.append(item2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsForSell.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ItemForSellCell") as UITableViewCell
        
        cell.textLabel?.text = self.itemsForSell[indexPath.row].title
        cell.detailTextLabel?.text = "价格： \(self.itemsForSell[indexPath.row].price)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var itemDetailViewController: ItemDetailViewController = segue.destinationViewController as ItemDetailViewController
        var itemIndex = itemsTable!.indexPathForSelectedRow()!.row;
        var selectedItem = self.itemsForSell[itemIndex]
        itemDetailViewController.item = selectedItem
        
    }
    
}