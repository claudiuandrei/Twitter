//
//  User.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/1/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class User: NSObject {
    
    var id: Int?
    var name: String?
    var location: String?
    var screenName: String?
    var tagLine: String?
    var profileImageUrl: URL?
    
    var dictionary: NSDictionary?
    var requestToken: BDBOAuth1Credential?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        location = dictionary["location"] as? String
        screenName = dictionary["screen_name"] as? String
        tagLine = dictionary["description"] as? String
        
        if let profileImageUrlString = dictionary["profile_image_url_https"] as? String {
            profileImageUrl = URL(string: profileImageUrlString)
        }
    }
    
    static let onLogout = Notification.Name("UserLogout")
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            guard _currentUser == nil else { return _currentUser }
            
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? Data
            
            if let userData = userData {
                let dictionary = try? JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                guard let dict = dictionary else { return nil }
                
                _currentUser = User(dictionary: dict)
            }
            
            return _currentUser
        }
        
        set(user) {
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
