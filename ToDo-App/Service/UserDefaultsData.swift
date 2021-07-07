//
//  UserDefaultsData.swift
//  PolymathLabs TechnicalChallenge
//
//  Created by Dion Dula on 2/27/21.
//

import Foundation

class UserDefaultsData: NSObject {
    
    static let shared = UserDefaultsData()
    
    private static let enableAutoLoginKey = "enable_auto_login_key"
    private static let tokenKey = "token_Key"
    private static let idKey = "id_Key"
    private static let usernameKey = "username_Key"
    private static let nameKey = "name_Key"
    private static let surNameKey = "surName_Key"
    private static let emailKey = "email_Key"
    private static let withtoutNetworkLoginKey = "whithout_network_login_key"
    
    static var enableAutoLogin: Bool {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.bool(forKey:enableAutoLoginKey)
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: enableAutoLoginKey)
        }
    }
    
    static var isNetworkLogin: Bool {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.bool(forKey: withtoutNetworkLoginKey)
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: withtoutNetworkLoginKey)
        }
    }
    
    
    static var token: String {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.string(forKey: tokenKey) ?? ""
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
    
    static var id: String {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.string(forKey: idKey) ?? ""
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: idKey)
        }
    }
    
    static var username: String {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.string(forKey: usernameKey) ?? ""
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: usernameKey)
        }
    }
    
    static var name: String {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.string(forKey: nameKey) ?? ""
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    
    static var surname: String {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.string(forKey: surNameKey) ?? ""
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: surNameKey)
        }
    }
    
    static var email: String {
        get {
            // Read from UserDefaults
            return UserDefaults.standard.string(forKey: emailKey) ?? ""
        }
        set {
            // Save to UserDefaults
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }
}
