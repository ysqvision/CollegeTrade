//
//  SearchItemAPIController.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/20/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

protocol didReceiveItemsProtocol {
    func didReceiveItems(results: NSDictionary)
}

class SearchItemAPIController {
   
    var delegate: didReceiveItemsProtocol?
    
    init() {
    }
    
    func getAllItems() {
    
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-getGoodsListByTimestampSmall"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        //var params = ["username":"b", "password":"2"] as Dictionary<String, String>
        let date = NSDate()
        let timestamp = date.timeIntervalSince1970
        var requestBody = "newestTimestamp=\(timestamp)"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
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
            self.delegate?.didReceiveItems(json!)
        })
        
        println("herherhe")
        
        task.resume()
    }
}