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
    
    
    func getItemsWithName(name: String) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-getGoodsListByName"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)
        //var params = ["username":"b", "password":"2"] as Dictionary<String, String>
        var requestBody = "GoodsName=\(name)&Flag=0&time=\(timestamp)"
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
                println(json!)
                self.delegate?.didReceiveItems(json!)
                
            }
        })
        
        task.resume()

    }
    
    
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
    
    func getUserItems(userId: Int) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-getGoodsListByUserId"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        //var params = ["username":"b", "password":"2"] as Dictionary<String, String>
        let date = NSDate()
        let timestamp = Int(date.timeIntervalSince1970 * 1000)
        var requestBody = "UserId=\(userId)&Time=\(timestamp)&Flag=1&Count=1000"
        println("requestBody: \(requestBody)")
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
        
        
        
        
        
        /*
        let manager = AFHTTPRequestOperationManager()
        //var acceptedValue = NSMutableSet()
        //acceptedValue.addObject("text/html")
        
      //  manager.responseSerializer.acceptableContentTypes = acceptedValue
    ///var userId: Int =  LOGGED_IN_USER_INFORMATION!["Userid"] as Int
       // var userId: Int = 1
        var timeStamp: Int = Int(NSDate().timeIntervalSince1970 * 1000)
        var parameter: [String: String] = ["UserId": "\(userId)", "Time": "\(timeStamp)", "Flag": "0", "Count": "1000"]
       println("hereSDFSD")
        manager.POST("http://14.29.65.186:9090/SpiriiitTradeServer/user-getGoodsListByUserId", parameters: parameter,
            success: { operation, response in
                var err: NSError?
                var jsonResponse = NSJSONSerialization.JSONObjectWithData(response as NSData, options: .MutableLeaves, error: &err) as? NSDictionary
                println(response)
                if (err != nil) {
                    println(err)
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
}