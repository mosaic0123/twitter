//
//  User.swift
//  Twitter
//
//  Created by tingting_gao on 11/3/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenName: String?
    var profileURL: URL?
    var tagline: String?

    var dictionary: NSDictionary?

    // De-serialization: dict -> object
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screenName"] as? String

        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }

        tagline = dictionary["description"] as? String
    }

    static var _currentUser: User?

    // Computed property
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data

                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                    }
                }
                return _currentUser
        }

        set(user) {
            _currentUser = user
            
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
