//
//  UserHomePageViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 9/16/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class UserHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didReceiveItemsProtocol {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let kCellIdentifier: String = "ItemForSellCell"
    var itemsForSell = []
    var searchItemAPI = SearchItemAPIController()
    
    var imageCache = [String: UIImage]()
    
    @IBOutlet weak var transition: UIButton!
    @IBOutlet weak var itemsTable: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername("456", password: "123456", completion:
            { response, error in
                if ((error) != nil) {
                    println("cannot login")
                    println(error)
                } else {
                    println("success")
                }
                
            }, onQueue: nil)

        activityIndicator.startAnimating();
        searchItemAPI.delegate = self
        searchItemAPI.getAllItems()
        if USER_IS_LOGGED_IN == false {
            println("is false")
            var storedUsername = KeychainService.loadToken("SPIRIIITCOLLEGETRADEUSERNAME")
            if (storedUsername != nil && storedUsername! != "") {
                var storedPassword = KeychainService.loadToken("SPIRIIITCOLLEGETRADEPASSWORD")
                DataBaseAPIHelper.checkLoginCredential(storedUsername!, password: storedPassword!) { (success: Bool) -> () in
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if success {
                            USER_IS_LOGGED_IN = true
                        }
                    })
                }
            }
        }
        
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
        
        if let imagePaths = rowData["goodsImage"] as? [String] {
            if imagePaths.count != 0 {
                var firstImage = imagePaths[0]
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