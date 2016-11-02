//
//  TweetViewCell.swift
//  Twitter
//
//  Created by Claudiu Andrei on 11/1/16.
//  Copyright © 2016 Claudiu Andrei. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {
    
    // Load the delegate back
    weak var delegate: TweetsViewController?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var tweet: Tweet? {
        didSet {
            guard nameLabel != nil else { return }
            
            if let tweet = tweet {
                messageLabel.text = tweet.text
                nameLabel.text = tweet.user!.name
                retweetCountLabel.text = String(tweet.retweetCount)
                favoritesCountLabel.text = String(tweet.favoritesCount)
                screenNameLabel.text = "@\(tweet.user!.screenName!)"
                timeLabel.text = String(describing: tweet.timeStamp)
                
                profileImageView.setImageWith(tweet.user!.profileImageUrl!)
                profileImageView.layer.cornerRadius = 8
                
                if tweet.favorited ?? false {
                    favoriteButton.setImage(#imageLiteral(resourceName: "Star"), for: .normal)
                } else {
                    favoriteButton.setImage(#imageLiteral(resourceName: "StarWhite"), for: .normal)
                }
                if tweet.retweeted ?? false {
                    retweetButton.setImage(#imageLiteral(resourceName: "Tweet"), for: .normal)
                } else {
                    retweetButton.setImage(#imageLiteral(resourceName: "TweetWhite"), for: .normal)
                }
            }
        }
    }

    @IBAction func onReplyButton(_ sender: AnyObject) {
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
    }
    
    @IBAction func onFavoriteButton(_ sender: AnyObject) {
    }


}
