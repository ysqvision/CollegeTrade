import UIKit
import Security

// Identifiers
let serviceIdentifier = "MySerivice"
let userAccount = "authenticatedUser"
let accessGroup = "MySerivice"

class KeychainService: NSObject {
    
    /**
    * Exposed methods to perform queries.
    * Note: feel free to play around with the arguments
    * for these if you want to be able to customise the
    * service identifier, user accounts, access groups, etc.
    */
    public class func saveToken(userName: NSString, token: NSString) {
        self.save(serviceIdentifier, userName: userName, data: token)
    }
    
    public class func loadToken(userName: NSString) -> NSString? {
        var token = self.load(serviceIdentifier, userName: userName)
        
        return token
    }
    
    public class func removeToken(userName: NSString, token: NSString) {
        self.remove(serviceIdentifier, userName: userName, data: token)

    }
    
    private class func remove(service: NSString, userName: NSString, data: NSString) {
        var dataFromString: NSData = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, service, userName, dataFromString], forKeys: [kSecClass, kSecAttrService, kSecAttrAccount, kSecValueData])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionaryRef)

    }
    /**
    * Internal methods for querying the keychain.
    */
    private class func save(service: NSString, userName: NSString, data: NSString) {
        var dataFromString: NSData = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, service, userName, dataFromString], forKeys: [kSecClass, kSecAttrService, kSecAttrAccount, kSecValueData])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionaryRef)
        
        // Add the new keychain item
        var status: OSStatus = SecItemAdd(keychainQuery as CFDictionaryRef, nil)
        print(status)
    }
    
    private class func load(service: NSString, userName: NSString) -> NSString? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        var keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPassword, service, userName, kCFBooleanTrue, kSecMatchLimitOne], forKeys: [kSecClass, kSecAttrService, kSecAttrAccount, kSecReturnData, kSecMatchLimit])
        
        var dataTypeRef :Unmanaged<AnyObject>?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        
        let opaque = dataTypeRef?.toOpaque()
        
        var contentsOfKeychain: NSString?
        
        if let op = opaque? {
            let retrievedData = Unmanaged<NSData>.fromOpaque(op).takeUnretainedValue()
            
            // Convert the data retrieved from the keychain into a string
            contentsOfKeychain = NSString(data: retrievedData, encoding: NSUTF8StringEncoding)
        } else {
            println("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}