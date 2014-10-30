//
//  UpYunHelper.swift
//  CollegeTrade
//
//  Created by Shaoqing Yang on 10/27/14.
//  Copyright (c) 2014 Shaoqing Yang. All rights reserved.
//

import Foundation
import UIKit

class UpYunHelper {
    
    class func postPicture (image: UIImage, fileName: String, uploadSuccess: (success: Bool, url: String) -> ()){
        
       // var bucket = "bucket"
        var expiration: Int = Int(NSDate().timeIntervalSince1970 + 900.0)
        var options = [String: String]()
        options["bucket"] = "spiriiit-sharejx"
        options["expiration"] = "\(expiration)"
        options["save-key"] = "\(fileName)"
        options["allow-file-type"] = "jpeg,gif,png"
        var optionsString = String()
        
        if NSJSONSerialization.isValidJSONObject(options) {
            let data = NSJSONSerialization.dataWithJSONObject(options, options: nil, error: nil)
            optionsString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            println("optionsString: \(optionsString)")
        }
        
        let utf8str = optionsString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let policy = utf8str!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.fromRaw(0)!)
        println("policy: \(policy)")
        let signature = "\(policy)&\(UPYUN_SECRET_KEY)".strasnerMD5()
        
        println("signature: \(signature)")
        
        var imageData = UIImagePNGRepresentation(image)
        var parameter: [String: String] = ["policy": policy, "signature": signature]
        let manager = AFHTTPRequestOperationManager()
        var acceptedValue = NSMutableSet()
        acceptedValue.addObject("text/html")
    
        manager.responseSerializer.acceptableContentTypes = acceptedValue
        
        manager.POST("http://v0.api.upyun.com/spiriiit-sharejx/", parameters: parameter, constructingBodyWithBlock: {
            (data: AFMultipartFormData!) in
            data.appendPartWithFileData(imageData, name: "file", fileName: "switch.png", mimeType: "image/png")
            }, success: { operation, response in
                println(response)
                uploadSuccess(success: true, url: "")
               // let responseString: String = "\(response)"
               // var responseData: NSData = responseString.dataUsingEncoding(NSUTF8StringEncoding)!
                
               // var err: NSError?
              //  var jsonResponse = NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableLeaves, error: &err) as? NSDictionary
               // if (err != nil) {
                 //   uploadSuccess(success: false, url: "")
                   // return
                //}
                /*
                if let parsedJSON = jsonResponse {
                    var code = parsedJSON["code"] as? Int
                    if code == 200 {
                        //var url = parsedJSON["url"] as NSString
                        uploadSuccess(success: true, url: "")
                        return
                    }
                    else {
                        uploadSuccess(success: false, url: "")
                        return
                    }
                }
*/
            },
            failure: {operation, error in
                println(error)
                uploadSuccess(success: false, url: "")
            }
        )
     
        /*
        var request = NSMutableURLRequest(URL: NSURL(string: "http://v0.api.upyun.com/spiriiit-sharejx/"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var imageData = UIImagePNGRepresentation(image)
        let boundary = "WebKitFormBoundary6yCbA8qXybHrqjBn"
        let contentType = "multipart/form-data; boundary=\(boundary)"
       request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        //var requestBody = "username=\(username)&password=\(password)&UserImage=image&SchoolId=3&NickName=nick"
        var requestBody = NSMutableData()
        requestBody.appendData("\r\n--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData("Content-Disposition: form-data; name=\"policy\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData("\(policy)".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        requestBody.appendData("--\r\n\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData("Content-Disposition: form-data; name=\"signature\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData("\(signature)".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        requestBody.appendData("--\r\n\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"switch.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBody.appendData(imageData)
        requestBody.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        requestBody.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)

        
        request.HTTPBody = requestBody
        var length = "\(requestBody.length)"
        request.setValue(length, forHTTPHeaderField: "Content-Length")
        // request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        //request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        //print(NSString(data: requestBody, encoding: N
           // SUTF8StringEncoding))
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
                uploadSuccess(success: false)
                return
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var code = parseJSON["code"] as? Int
                    if code == 201 {
                        uploadSuccess(success: true)
                        return
                    }
                    else {
                        uploadSuccess(success: false)
                        return
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    uploadSuccess(success: false)
                    return
                }
            }
        })
        task.resume()
*/
        
        

    }
}

