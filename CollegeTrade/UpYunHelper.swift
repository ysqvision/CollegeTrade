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
        options["save-key"] = "\(UPYUN_BUCKET)/\(fileName)"
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
        
        manager.POST(UPYUN_PUBLIC_DOMAIN, parameters: parameter, constructingBodyWithBlock: {
            (data: AFMultipartFormData!) in
            data.appendPartWithFileData(imageData, name: "file", fileName: "switch.png", mimeType: "image/png")
            }, success: { operation, response in
                println(response)
                uploadSuccess(success: true, url: "")
                           },
            failure: {operation, error in
                println(error)
                uploadSuccess(success: false, url: "")
            }
        )
        

    }
}

