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
        
        activityIndicator.startAnimating();
        searchItemAPI.delegate = self
        
        searchItemAPI.getAllItems()
        
        
       // activityIndicator.stopAnimating();
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
    //    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ItemForSellCell")
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ItemForSellCell") as UITableViewCell
        //let rowDataArray: NSArray = self.itemsForSell[indexPath.row] as NSArray
        let rowData: NSDictionary = self.itemsForSell[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["goodsName"] as NSString
        println(rowData["goodsName"])
        
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
            //var selectedItemSet = self.itemsForSell[itemIndex] as NSArray
            var selectedItem = self.itemsForSell[itemIndex]  as NSDictionary
            //var title = selectedItem["goodsName"] as NSString
            //var price = selectedItem["price"] as Double
            //var description = selectedItem["goodsDescription"] as String
            //println(selectedItem["goodsImage"])
            //var imageUrlString = selectedItem["goodsImage"] as String
            ///println(imageUrlString)
            //var imageUrl = imageUrlString.componentsSeparatedByString(",")
           // var item = ItemForSell(title: title, price: price, description: description, imageUrl: imageUrl)
            itemDetailViewController.item = selectedItem
          //  var additionalInformation = selectedItemSet[1] as NSDictionary
         //   itemDetailViewController.item = additionalInformation
       
        }
        
    }
    func didReceiveItems(results: NSDictionary) {
        var resultsArr: NSArray = results["data"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.itemsForSell = resultsArr
            println(self.itemsForSell)
            self.itemsTable!.reloadData()
            self.activityIndicator.stopAnimating()
        })
    }
    
    
}