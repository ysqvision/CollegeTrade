//
//  UserStoreHomePageViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/28/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//


import UIKit

class UserStoreHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didReceiveItemsProtocol, postNewItemProtocol {
    var userIdForThisStore: Int?
    var storeId: Int?
    let kCellIdentifier: String = "ItemForSellCell"
    var itemsForSell = []
    var searchItemAPI = SearchItemAPIController()
    
    var isMyStore = false
    
    @IBOutlet weak var itemsTable: UITableView!
    
    @IBOutlet var addNewItemButton: UIButton!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if USER_IS_LOGGED_IN == false {
            
            self.performSegueWithIdentifier("ShowLoginScreenFromUserStore", sender: self)
        }
        itemsTable.reloadData()
    }
    
    override func viewDidLoad() {
        //var selfId = LOGGED_IN_USER_INFORMATION!["userId"] as String
        println("userid for this store  \(userIdForThisStore)")
        var selfUserId = LOGGED_IN_USER_INFORMATION!["userId"] as Int
        if userIdForThisStore != selfUserId {
            println("id is not smae")
            isMyStore = false
   
            addNewItemButton.hidden = true
            /*
            var toolbarButtons = self.toolbarItems
            toolbarButtons.
            addNewItemButton.enabled = false
            addNewItemButton.hidden = true
*/
        } else {
            isMyStore = true
        }
        searchItemAPI.delegate = self
        searchItemAPI.getUserItems(userIdForThisStore!)
        
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
        let rowDataArray: NSArray = self.itemsForSell[indexPath.row] as NSArray
        let rowData: NSDictionary = rowDataArray[0] as NSDictionary
        
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
        
        if isMyStore {
            performSegueWithIdentifier("ShowEditItemViewSegue", sender: self)
        } else {
            performSegueWithIdentifier("ShowItemDetailViewSegue", sender: self)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier != "ShowNewItemForSellViewSegue" && segue.identifier != "ShowLoginScreenFromUserStore") {
            println(segue.identifier)
            var itemDetailViewController: ItemDetailViewController = segue.destinationViewController as ItemDetailViewController
            var itemIndex = itemsTable!.indexPathForSelectedRow()!.row;
           
            var selectedItemSet = self.itemsForSell[itemIndex] as NSArray
            var selectedItem = selectedItemSet[0] as NSDictionary
            var additionalInformation = selectedItemSet[1] as NSDictionary
            itemDetailViewController.item = additionalInformation
        
        }
        if segue.identifier == "ShowNewItemForSellViewSegue" {
            var newItemForSellViewController: NewItemForSellViewController = segue.destinationViewController as NewItemForSellViewController
            newItemForSellViewController.delegate = self
        } else if segue.identifier == "ShowEditItemViewSegue" {
            
            var itemEditViewController: EditItemViewController = segue.destinationViewController as EditItemViewController
            var itemIndex = itemsTable!.indexPathForSelectedRow()!.row;
            var selectedItemSet = self.itemsForSell[itemIndex] as NSArray
            var selectedItem = selectedItemSet[0] as NSDictionary
            var additionalInformation = selectedItemSet[1] as NSDictionary
            itemEditViewController.itemToEdit = selectedItem
            itemEditViewController.goodsID = additionalInformation["goodsId"] as Int
            
        }
    }

    
    func didReceiveItems(results: NSDictionary) {
        var resultsArr: NSArray = results["data"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.itemsForSell = resultsArr
            self.itemsTable!.reloadData()
        })
    }
    
    func didPostNewItem() {
        searchItemAPI.getUserItems(userIdForThisStore!)
    }
}
