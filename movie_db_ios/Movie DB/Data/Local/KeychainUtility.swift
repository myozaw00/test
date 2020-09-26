//
//  KeychainUtility.swift
//  Digital Onboard
//
//  Created by Myo Zaw Oo on 18/08/2020.
//

import Foundation
import KeychainAccess

struct Keys {
    static let ACCESS_TOKEN = "access_token"
    static let REFRESH_TOKEN = "refresh_token"
}


class KeychainUtility {
    
    static let lockCredentials = Keychain(service: AppConstants.BUNDLE_IDENTIFIER)
    
    static func save(key: String, value: String) {
        do {
            try lockCredentials.set(value, key: key)
        }catch let error {
            print("KEYCHAIN SAVE :: Failed to save this value with this key \(key) => \(error)")
        }
    }
    
    static func saveObject(key: String, value: Data) {
        do {
            try lockCredentials.set(value, key: key)
        }catch let error {
            print("KEYCHAIN SAVE OBJ:: Failed to save this value with this key \(key) => \(error)")
        }
    }
    
    static func get(key: String) -> String {
        var storedData: String?
        storedData = lockCredentials[string: key]
        guard let data = storedData, !data.isEmpty else {
            
            return ""
        }
        return data
    }
    
    static func getAccessToken() -> String {
        var storedData: String?
        storedData = lockCredentials[string: Keys.ACCESS_TOKEN]
        guard let data = storedData, !data.isEmpty else {            
            return ""
        }
        return "Bearer \(data)"
    }
    
    static func getRefreshToken() -> String {
        var storedData: String?
        storedData = lockCredentials[string: Keys.REFRESH_TOKEN]
        guard let data = storedData, !data.isEmpty else {
            return ""
        }
        return data
    }
    
    static func getObject(key: String) -> Any {
        var storedData: Any?
        storedData = NSKeyedUnarchiver.unarchiveObject(with: lockCredentials[data: key]!)
        
        guard let data = storedData else {
            return ""
        }
        return data
    }
    
    static func delete(key: String) {
        do {
            try lockCredentials.remove(key)
        } catch let error {
            print("KEYCHAIN DELETE :: Failed to remove keychain data with this key : \(key) => \(error)")
        }
    }
    
    static func removeAll() {
        do {
            try lockCredentials.removeAll()
        } catch {
            print("KEYCHAIN REMOVE ALL :: Failed to remove all keychain data")
        }
    }
    
    
    
}
        
