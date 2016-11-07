//
//  TwitterClient.swift
//  Twitter
//
//  Created by tingting_gao on 11/3/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    // static let userDidLogoutNotification = "UserDidLogout"

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "IYtXw8B7Z0Ftmnxnq3VsTRRLT", consumerSecret: "qXF0jYU2o7qD4x8NEwH9jN5XNaUwbnQqk6z9UUNWwICggMI9LV")

    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?

    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {

        loginSuccess = success
        loginFailure = failure

        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in

            print("I got a token")

            let token = requestToken!.token!

            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!

            UIApplication.shared.openURL(url)

        }){(error:Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
    }

    func findUser(userID: String, screenName: String)  {
        TwitterClient.sharedInstance?.post("1.1/users/show.json", parameters: ["id" : userID], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
                print(response)
                print("🍞request succeed!")
            }, failure: {
                (task: URLSessionDataTask?, error: Error) -> Void in
                print(error.localizedDescription)
        })

    }

    func retweetTweet(tweetID: String) {
        TwitterClient.sharedInstance?.post("1.1/statuses/retweet/\(tweetID).json", parameters: ["id" : tweetID], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            }, failure: {
                (task: URLSessionDataTask?, error: Error) -> Void in
                print(error.localizedDescription)
        })
    }

    func likeTweet(tweetID: String) {
        TwitterClient.sharedInstance?.post("1.1/favorites/create.json", parameters: ["id" : tweetID], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            }, failure: {
                (task: URLSessionDataTask?, error: Error) -> Void in
                print(error.localizedDescription)
        })
    }

    func unLikeTweet(tweetID: String) {
        TwitterClient.sharedInstance?.post("1.1/favorites/destroy.json", parameters: ["id" : tweetID], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            }, failure: {
                (task: URLSessionDataTask?, error: Error) -> Void in
                print(error.localizedDescription)
        })
    }

    func postTweet(tweet: String) {

        TwitterClient.sharedInstance?.post("1.1/statuses/update.json", parameters: ["status" : tweet], progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            }, failure: {
                (task: URLSessionDataTask?, error: Error) -> Void in
                print(error.localizedDescription)
        })
    }

    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error)->()) {

            get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in

            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
                print("homeTimeLine failed! 💀")
        })
    }

    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in

            self.currentAccount(success: {
                (user:User) -> () in
                    // Call the setter 
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error:Error) -> () in
                    self.loginFailure?(error)
                }
            )

        })
            { (error: Error?) -> Void in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
    }
    }

    func currentAccount(success: @escaping (User)->(), failure: @escaping (Error)->()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDict = response as! NSDictionary

            let user = User(dictionary: userDict)

            success(user)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
    }

    func logout() {
        User.currentUser = nil
        deauthorize()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
    }
}
