//
//  Tweet.swift
//  Twitter
//
//  Created by tingting_gao on 11/3/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var userName: String?
    var userImageURL: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var favorited: Bool = false
    var retweeted: Bool = false
    var tweetID: String?

    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String

        if let userDict = dictionary["user"] as? NSDictionary {
            userName = userDict["name"] as? String
            userImageURL = userDict["profile_image_url"] as? String
        }

        tweetID = dictionary["id_str"] as? String
    
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0

        let timestampString = dictionary["created_at"] as? String

        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }

        if (dictionary["favorited"] as! Int) == 1 {
            favorited = true
        }

        if (dictionary["retweeted"] as! Int) == 1 {
            retweeted = true
        }
    }

    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()

        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }

        return tweets
    }
}
