//
//  ComposeViewController.swift
//  Twitter
//
//  Created by tingting_gao on 11/6/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

struct Constants {
    static let blueColor = UIColor(colorLiteralRed: 106/255.0, green: 191/255.0, blue: 252/255.0, alpha: 1)
    static let redColor = UIColor(colorLiteralRed: 244/255.0, green: 75/255.0, blue: 95/255.0, alpha: 1)
    static let greenColor = UIColor(colorLiteralRed: 139/255.0, green: 249/255.0, blue: 158/255.0, alpha: 1)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        textView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = String(140 - textView.text.characters.count)
    }

    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onPublishButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.postTweet(tweet: textView.text)
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
