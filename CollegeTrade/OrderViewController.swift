//
//  OrderViewController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/29/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, didGetOrderResultsProtocol {
    
    @IBOutlet var orderTable: UITableView!
    
    var buyOrderList = [String: String]()
    
    var sellOrderList = [String: String]()
    
    var isFirstSelected = false
    
    var orderController = OrderAPIHelper()
    
    override func viewDidLoad() {
        if USER_IS_LOGGED_IN == false {
            self.performSegueWithIdentifier("ShowLoginScreenFromUserStore", sender: self)
        }
        orderController.delegate = self
        
        switch segment.selectedSegmentIndex
            {
        case 0:
            isFirstSelected = true
        case 1:
            isFirstSelected = false
        default:
            break;
        }
        
       
        super.viewDidLoad()
        orderTable.tableFooterView = UIView(frame: CGRect.zeroRect)
    }
    
    @IBOutlet var segment: UISegmentedControl!
    
    @IBAction func segmentChanged(sender: AnyObject) {
        var index = segment.selectedSegmentIndex
        
        if index == 0 {
            isFirstSelected = true
            orderController.getBuyOrderCount()
        }
        else if (index == 1) {
            isFirstSelected = false
            orderController.getSellOrderCount()
        }
        orderTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        if isFirstSelected {
            return buyOrderList.count
        }
        else {
            return sellOrderList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ItemForSellCell")
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("OrderCell") as UITableViewCell
        if isFirstSelected {
            cell.textLabel?.text = "first"
        }
        else {
            cell.textLabel?.text = "second"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GetOrderDetailSegue" {
            var orderDetailViewController: OrderDetailViewController = segue.destinationViewController as OrderDetailViewController
            
            var isBuy = false
            var index = segment.selectedSegmentIndex
            
            if index == 0 {
               isBuy = true
            }
            else if (index == 1) {
                isBuy = false            }

            orderDetailViewController.isBuyOrder = isBuy
        
        }
    }
    
    func didGetBuyOrderCount(results: Int) {
        if (results != buyOrderList.count) {
            orderController.getBuyOrders()
        }
    }
    
    func didGetSellOrderCount(results: Int) {
        if (results != sellOrderList.count) {
            orderController.getSellOrders()
        }
    }
    
    func didGetSellOrders(results: NSDictionary) {
        sellOrderList = results as [String: String]
        orderTable.reloadData()
    }
    
    func didGetBuyOrders(results: NSDictionary) {
        buyOrderList = results as [String: String]
        orderTable.reloadData()
    }
}

