//
//  TweetsViewController.swift
//  Twitter
//
//  Created by tingting_gao on 11/4/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]! = []

    var selectedTweet: Tweet?

    @IBOutlet weak var tableView: UITableView!

    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: "refreshControlAction", for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in

            self.tweets = tweets

            self.tableView.reloadData()
            self.tableView.estimatedRowHeight = 250.0
            self.tableView.rowHeight = UITableViewAutomaticDimension

            }, failure: {
                (error: Error) -> () in
                print(error.localizedDescription)
        })
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadTweets()
    }

    func reloadTweets() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in

            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()

            }, failure: {
                (error: Error) -> () in
                print(error.localizedDescription)
        })
    }

    func refreshControlAction() {
        reloadTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell

        if self.tweets.count > 0 {

            let tweet = self.tweets[indexPath.row]
            cell.usernameLabel.text = tweet.userName
            cell.contentLabel.text = tweet.text
            cell.contentLabel.preferredMaxLayoutWidth = cell.contentLabel.frame.size.width
            cell.contentLabel.sizeToFit()

            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            var dateString = dateFormatter.string(from: tweet.timestamp!)
            cell.timeLabel.text = dateString

            cell.profileImageView.setImageWith(URL(string: tweet.userImageURL!)!)
            cell.profileImageView.layer.cornerRadius = 10.0
            cell.profileImageView.clipsToBounds = true

            cell.retweetLabel.text = String(tweet.retweetCount)
            cell.likeLabel.text = String(tweet.favoriteCount)

            cell.likeButton.tintColor = tweet.favorited ? Constants.redColor : Constants.blueColor

            cell.retweetButton.tintColor = tweet.favorited ? Constants.greenColor : Constants.blueColor
        }

        return cell
    }

    @IBAction func onLogOut(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRow" {
            var detailViewController = segue.destination as! DetailViewController
            let cell = sender as! TweetCell
            let index = tableView.indexPath(for: cell)
            selectedTweet = tweets[(index?.row)!]
            if selectedTweet != nil {
                detailViewController.tweet = selectedTweet!
            }
        }
    }


}
