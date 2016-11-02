//
//  LoginViewController.swift
//  Twitter
//
//  Created by tingting_gao on 11/2/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "IYtXw8B7Z0Ftmnxnq3VsTRRLT", consumerSecret: "qXF0jYU2o7qD4x8NEwH9jN5XNaUwbnQqk6z9UUNWwICggMI9LV")

        twitterClient?.deauthorize()

        twitterClient?.fetchRequestToken(withPath: "https://api.twitter.com/oauth/request_token", method: "GET", callbackURL: nil, scope: nil, success: ({(requestToken: BDBOAuth1Credential?) -> Void in print("I got a token")}), failure: ({(error:Error?) -> Void in print("error: \(error?.localizedDescription)")}))
    }       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
