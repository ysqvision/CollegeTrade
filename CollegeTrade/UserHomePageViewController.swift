//
//  UserHomePageViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didReceiveItemsProtocol {

    @IBOutlet var searchBox: UITextField!
    @IBAction func searchForItems(sender: AnyObject) {
        if searchBox.text == "" {
            searchItemAPI.getAllItems()
        } else {
            var searchString = searchBox.text
            searchItemAPI.getItemsWithName(searchString)
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let kCellIdentifier: String = "ItemForSellCell"
    var itemsForSell = []
    var searchItemAPI = SearchItemAPIController()
    
    var imageCache = [String: UIImage]()
    
    @IBOutlet weak var transition: UIButton!
    @IBOutlet weak var itemsTable: UITableView?
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.hidden = false
        activityIndicator.startAnimating();
        searchItemAPI.delegate = self
        
        searchItemAPI.getAllItems()
        
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
        let rowData: NSDictionary = self.itemsForSell[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["goodsName"] as NSString
        println(rowData["goodsName"])
        
    
        let formattedPrice: Double = rowData["price"] as Double
        cell.detailTextLabel?.text = "价格: \(formattedPrice)"
        cell.imageView?.image = UIImage(named: "Placeholder.png")
      
        //var imagePaths = rowData["goodsImage"] as String
        if let imagePaths = rowData["goodsImage"] as? String {
            var imagePathSet = imagePaths.componentsSeparatedByString(",")

            if imagePathSet.count != 0 {
                var firstImage = imagePathSet[0]
                var image = imageCache[firstImage]
                if( image == nil ) {
                    // If the image does not exist, we need to download it
                    var imgURL: NSURL = NSURL(string: firstImage)
                    
                    // Download an NSData representation of the image at the URL
                    let request: NSURLRequest = NSURLRequest(URL: imgURL)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                        if error == nil {
                            image = UIImage(data: data)
                            
                            // Store the image in to our cache
                            self.imageCache[firstImage] = image
                            dispatch_async(dispatch_get_main_queue(), {
                                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                                    cellToUpdate.imageView?.image = image
                                }
                            })
                        }
                        else {
                            println("Error: \(error.localizedDescription)")
                        }
                    })
                    
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                            cellToUpdate.imageView?.image = image
                        }
                    })
                }
            }
        } else {
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowItemDetailViewSegue") {
            var itemDetailViewController: ItemDetailViewController = segue.destinationViewController as ItemDetailViewController
            var itemIndex = itemsTable!.indexPathForSelectedRow()!.row;
            var selectedItem = self.itemsForSell[itemIndex]  as NSDictionary
       
            itemDetailViewController.item = selectedItem
        }
        
    }
    func didReceiveItems(results: NSDictionary) {
        var resultsArr: NSArray = results["data"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.itemsForSell = resultsArr
            println(self.itemsForSell)
            self.itemsTable!.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
        })
    }
    
    
}