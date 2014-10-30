//
//  OrderAPIHelper.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/29/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation


protocol didGetOrderResultsProtocol {
    func didGetBuyOrders(results: NSDictionary)
    
    func didGetSellOrders(results: NSDictionary)
    
    func didGetBuyOrderCount(results: Int)
    
    func didGetSellOrderCount(results: Int)
}


class OrderAPIHelper {
    
    var delegate: didGetOrderResultsProtocol?
    
    init() {
    }
    
    class func completeOrder(userSession: String, orderId: Int, updateSuccess: (success: Bool) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-updateOrdersToDone"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var requestBody = "userSession=\(userSession)&orderId=\(orderId)"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            // println("Response: \(response)")
            // println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            // println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["status"] as? Int
                    if code == 101 {
                        println("Setting status to be true")
                        updateSuccess(success: true)
                        return
                    }
                    else {
                        updateSuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    updateSuccess(success: false)
                    return
                }
            }
        })
        
        task.resume()
        
    }
    
    class func cancelOrder(userSession: String, orderId: Int, updateSuccess: (success: Bool) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-cancelOrder"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var requestBody = "userSession=\(userSession)&orderId=\(orderId)"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            // println("Response: \(response)")
            // println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            // println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["status"] as? Int
                    if code == 101 {
                        println("Setting status to be true")
                        updateSuccess(success: true)
                        return
                    }
                    else {
                        updateSuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    updateSuccess(success: false)
                    return
                }
            }
        })
        
        task.resume()
    }
    
    func getBuyOrders() {
        
    }
    
    func getSellOrders() {
    
    }
    
    func getBuyOrderCount() {
    
    }
    
    func getSellOrderCount() {
    
    }
    
    /*
    func getAllItems() {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-getGoodsListByTimestampSmall"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        //var params = ["username":"b", "password":"2"] as Dictionary<String, String>
        let date = NSDate()
        let timestamp = date.timeIntervalSince1970 * 1000
        var requestBody = "newestTimestamp=\(timestamp)"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            // println("Response: \(response)")
            // println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            // println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["Status"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
                
            }
            if (json != nil) {
                self.delegate?.didReceiveItems(json!)
                println(json!)
            }
        })
        
        task.resume()
    }
    
    func getUserItems() {
        
        let manager = AFHTTPRequestOperationManager()
        //var acceptedValue = NSMutableSet()
        //acceptedValue.addObject("text/html")
        
        //  manager.responseSerializer.acceptableContentTypes = acceptedValue
        ///var userId: Int =  LOGGED_IN_USER_INFORMATION!["Userid"] as Int
        var userId: Int = 1
        var timeStamp: String = "\(NSDate().timeIntervalSince1970 * 1000)"
        var parameter: [String: String] = ["Userid": "\(userId)", "Time": timeStamp, "Flag": "1", "Count": "1000"]
        
        manager.POST("http://14.29.65.186:9090/SpiriiitTradeServer/user-getGoodsListByUserId", parameters: parameter,
            success: { operation, response in
                var err: NSError?
                var jsonResponse = NSJSONSerialization.JSONObjectWithData(response as NSData, options: .MutableLeaves, error: &err) as? NSDictionary
                if (err != nil) {
                    return
                }
                if let parsedJSON = jsonResponse {
                    var code = parsedJSON["status"] as? Int
                    if code == 101 {
                        println(jsonResponse!)
                        self.delegate?.didReceiveItems(jsonResponse!)
                        return
                    }
                    else {
                        return
                    }
                }
            },
            failure: {operation, error in
                return
            }
        )
        
    }
*/
    
}