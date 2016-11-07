//
//  DetailViewController.swift
//  Twitter
//
//  Created by tingting_gao on 11/6/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tweet: Tweet?

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var userNameLabel: UILabel!

    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var retweetButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let tweet = tweet {
            userNameLabel.text = tweet.userName
            contentLabel.text = tweet.text
            // contentLabel.preferredMaxLayoutWidth = contentLabel.frame.size.width

            if tweet.favorited {
                likeButton.tintColor = Constants.redColor
            }
            else {
                likeButton.tintColor = Constants.blueColor
            }

            if tweet.retweeted {
                retweetButton.tintColor = Constants.greenColor
            }
            else {
                retweetButton.tintColor = Constants.blueColor
            }

            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            var dateString = dateFormatter.string(from: tweet.timestamp!)
            idLabel.text = dateString

            profileImageView.setImageWith(URL(string: tweet.userImageURL!)!)
            profileImageView.layer.cornerRadius = 10.0
            profileImageView.clipsToBounds = true

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLikeButton(_ sender: AnyObject) {
        if tweet?.favorited == false {
            TwitterClient.sharedInstance?.likeTweet(tweetID: (tweet?.tweetID)!)
            tweet?.favorited = true
            likeButton.tintColor = Constants.redColor
        }
        else {
           TwitterClient.sharedInstance?.unLikeTweet(tweetID: (tweet?.tweetID)!)
            tweet?.favorited = false
            likeButton.tintColor = Constants.blueColor
        }
    }


    @IBAction func onRetweetButton(_ sender: AnyObject) {
        if tweet?.retweeted == false {
            TwitterClient.sharedInstance?.retweetTweet(tweetID: (tweet?.tweetID)!)
            tweet?.retweeted = true
            retweetButton.tintColor = Constants.greenColor
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
