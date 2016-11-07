//
//  TweetCell.swift
//  Twitter
//
//  Created by tingting_gao on 11/4/16.
//  Copyright © 2016 tingting_gao. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var retweetLabel: UILabel!

    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
