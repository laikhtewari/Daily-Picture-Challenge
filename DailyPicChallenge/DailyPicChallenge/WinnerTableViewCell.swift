//
//  WinnerTableViewCell.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/4/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse
import Bond

class WinnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    var winnerPost: Post!  {
        didSet {
            // 1
            if let post = winnerPost {
                //2
                // bind the image of the post to the 'postImage' view
                post.image ->> winnerImageView
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setChallenge ()
    {
        //let challenge = self.winnerPost.challenge
        
        //let challengeString = ParseHelper.getInfoWithPost(winnerPost).challenge
        
//        let challengeString = self.winnerPost.challenge?.challenge
//        let username = self.winnerPost.user?.username
//        self.challengeLabel.text = challengeString
//        self.userLabel.text = username
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
