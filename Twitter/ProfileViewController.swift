//
//  ProfileViewController.swift
//  Twitter
//
//  Created by tingting_gao on 11/6/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userID: String?

    var screenName: String?

    var tweet: Tweet!

    // var screenName: String?

    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var screenNameLabel: UILabel!

    @IBOutlet weak var tweetsLabel: UILabel!

    @IBOutlet weak var followersLabel: UILabel!

    @IBOutlet weak var followingLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = tweet?.userName

        if let screenName = tweet?.screenName {
            screenNameLabel.text = "@\(screenName)"
        }

        if let statusCount = tweet?.statusCount {
            tweetsLabel.text = String(statusCount)
        }

        if let userFollowersCount = tweet?.userFollowersCount {
            followersLabel.text = String(userFollowersCount)
        }

        if let userFollowing = tweet?.userFollowing {
            followingLabel.text = String(userFollowing)
        }

        profileImageView.setImageWith(URL(string: (tweet?.userImageURL)!)!)
        bannerImageView.setImageWith(URL(string: (tweet?.bannerImageURL)!)!)

        //TwitterClient.sharedInstance?.findUser(userID: userID!, screenName: screenName!)
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
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
