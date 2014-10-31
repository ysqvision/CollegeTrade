//
//  DataBaseAPIHelper.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/21/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation

class DataBaseAPIHelper {
    
    class func userSignUp (username: String, password: String, loginSuccess: (success: Bool) -> ()){
        println("here")
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-register"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var requestBody = "username=\(username)&password=\(password)&UserImage=image&SchoolId=3&NickName=nick"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                loginSuccess(success: false)
                return
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["Status"] as? Int
                    if code == 101 {
                        //println("Setting status to be true")
                        //LOGGED_IN_USER_INFORMATION = json
                        //loginSuccess(success: true)
                        return
                    }
                    else {
                        loginSuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    loginSuccess(success: false)
                    return
                }
            }
        })
        task.resume()


    }

    class func checkLoginCredential(username: String, password: String, loginSuccess: (success: Bool) -> ()) {
        /*
        var parameter: [String: String] = ["username": username, "password": password]
        let manager = AFHTTPRequestOperationManager()
        manager.POST("http://14.29.65.186:9090/SpiriiitTradeServer/user-login", parameters: parameter,
            success: { operation, response in
                
                println(response)
                
                let responseString: String = "\(response)"
                var responseData: NSData = responseString.dataUsingEncoding(NSUTF8StringEncoding)!
                
                var err: NSError?
                var jsonResponse = NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableLeaves, error: &err) as? NSDictionary
                if (err != nil) {
                    loginSuccess(success: false)
                    return
                }
                
                if let parsedJSON = jsonResponse {
                    var code = parsedJSON["Status"] as? Int
                    if code == 101 {
                        //var url = parsedJSON["url"] as NSString
                        loginSuccess(success: true)
                        return
                    }
                    else {
                        loginSuccess(success: false)
                        return
                    }
                }
                
            },
            failure: {operation, error in
                println(error)
                loginSuccess(success: false)
            }
        )
*/
        
        // Check if username and password pass
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-login"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var requestBody = "username=\(username)&password=\(password)"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                loginSuccess(success: false)
                return
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["Status"] as? Int
                  
                    
                    if code == 101 {
                        println("Setting status to be true")
                        var body = parseJSON["data"] as? NSArray
                        LOGGED_IN_USER_INFORMATION = body![1] as NSDictionary
                        LOGGED_IN_USER_POINT = LOGGED_IN_USER_INFORMATION!["point"] as? Int
                        loginSuccess(success: true)
                        return
                    }
                    else {
                        loginSuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    loginSuccess(success: false)
                    return
                }
            }
        })
        task.resume()

    }
    
    class func buyItem(goodsID: String, address: String, phone: String, goodsPrice: String, buySuccess: (success: Bool) ->()) {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-buyGoods"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var timestamp = NSDate().timeIntervalSince1970 * 1000
        var type = 0
        
        var userId = LOGGED_IN_USER_INFORMATION!["userId"] as Int
       
        
        var requestBody = "goodsID=\(goodsID)&address=\(address)&Phone=\(phone)&goodsPrice=\(goodsPrice)&UserID=\(userId)&UserSession=0"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                buySuccess(success: false)
                return
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["Status"] as? Int
                    if code == 101 {
                        buySuccess(success: true)
                        return
                    }
                    else {
                        buySuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    buySuccess(success: false)
                    return
                }
            }
        })
        task.resume()

    }
    
    class func postItem(name: String, description: String, images: [String], price: String, quantity: String, postSuccess: (success: Bool) -> ()) {
        // Check if username and password pass
        var request = NSMutableURLRequest(URL: NSURL(string: "http://14.29.65.186:9090/SpiriiitTradeServer/user-postGoods"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var timestamp = NSDate().timeIntervalSince1970 * 1000
        var type = 0
        
        var userId = LOGGED_IN_USER_INFORMATION!["userId"] as Int
        println("userId is \(userId)")
        var joinedPaths = ",".join(images)
        var imageData: String = "\(joinedPaths)"
        
        var requestBody = "goodsName=\(name)&goodsDescription=\(description)&goodsImage=\(imageData)&newestTimestamp=\(timestamp)&price=\(price)&type=\(type)&userId=\(userId)&schoolId=0&specialPrice=0&categoryGoodsId=0&goodsInventory=\(quantity)"
        let data = requestBody.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        print(NSString(data:request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            println(error)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                postSuccess(success: false)
                return
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["Status"] as? Int
                    if code == 101 {
                        postSuccess(success: true)
                        return
                    }
                    else {
                        postSuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    postSuccess(success: false)
                    return
                }
            }
        })
        task.resume()

        
        
    }
    
    class func updateUserInformation(userId: String, keyValue: [String: String], updateSuccess: (success: Bool) -> ()) {
        
    }
    
    class func updateItemInformation(itemId: String, keyValue: [String: String], updateSuccess: (success: Bool) -> ()) {
    }
    
    class func updateStoreInformation(storeId: String, keyValue: [String: String], updateSuccess: (success: Bool) -> ()) {
    }
}