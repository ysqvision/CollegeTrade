//
//  UserStoreHomePageViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//


import UIKit

class UserStoreHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didReceiveItemsProtocol{
    let kCellIdentifier: String = "ItemForSellCell"
    var itemsForSell = []
    var searchItemAPI = SearchItemAPIController()
    
    @IBOutlet weak var itemsTable: UITableView!
    
    @IBAction func newItemForSellSegue(sender: AnyObject) {
        performSegueWithIdentifier("NewItemForSellSegue", sender: self)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if USER_IS_LOGGED_IN == false {
            self.performSegueWithIdentifier("ShowLoginScreenFromUserStore", sender: self)
        }
    }
    
    override func viewDidLoad() {
        searchItemAPI.delegate = self
        searchItemAPI.getUserItems()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsForSell.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ItemForSellCell")
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ItemForSellCell") as UITableViewCell
        let rowData: NSDictionary = self.itemsForSell[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["goodsName"] as NSString
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        // let urlString: NSString = rowData["goodsName"] as NSString
        //let imgURL: NSURL = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
        //let imgData: NSData = NSData(contentsOfURL: imgURL)
        //cell.imageView?.image = UIImage(data: imgData)
        
        // Get the formatted price string for display in the subtitle
        //let formattedPrice: NSString = rowData["price"] as NSString
        let formattedPrice: Double = rowData["price"] as Double
        cell.detailTextLabel?.text = "价格: \(formattedPrice)"
        cell.imageView?.image = UIImage(named: "randomcat1.png")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "NewItemForSellSegue" && segue.identifier != "ShowLoginScreenFromUserStore") {
            var itemDetailViewController: ItemDetailViewController = segue.destinationViewController as ItemDetailViewController
            var itemIndex = itemsTable!.indexPathForSelectedRow()!.row;
            var selectedItem = self.itemsForSell[itemIndex] as NSDictionary
            var title = selectedItem["goodsName"] as NSString
            var price = selectedItem["price"] as Double
            var item = ItemForSell(title: title, price: price)
            itemDetailViewController.item = item
        
        }
    }

    
    func didReceiveItems(results: NSDictionary) {
        var resultsArr: NSArray = results["data"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.itemsForSell = resultsArr
            self.itemsTable!.reloadData()
        })
    }
    
}