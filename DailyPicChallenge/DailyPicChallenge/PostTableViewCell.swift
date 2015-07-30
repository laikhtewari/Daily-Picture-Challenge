//
//  PostTableViewCell.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/24/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
//import Bond

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var post:Post? {
        didSet {
            // 1
            if let post = post {
                //2
                // bind the image of the post to the 'postImage' view
               // post.image ->> postImageView
            }
        }
    }

}
