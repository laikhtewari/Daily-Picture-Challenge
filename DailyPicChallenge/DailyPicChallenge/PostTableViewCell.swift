//
//  PostTableViewCell.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/24/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse
//import Bond

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func flagButtonTapped(sender: UIButton) {
       
        println ("flagbutton tapped")
        
        var postObjectID = ""
        
        let image = self.postImageView.image
        let imageData = UIImageJPEGRepresentation(image , 0.8 )
        
        if let usableData = imageData {
            println("starting query")
            
            let imageFile = PFFile (data: imageData )
            let postsQuery = Post.query()
            
            if let postVar = self.post {
                postObjectID = self.post!.objectId! as String
                println("post object ID: " + postObjectID)
            }
            
            postsQuery?.whereKey("objectId", equalTo: postObjectID)
            let post = postsQuery?.getFirstObject()
            println("query over")
            
            
//            let flag: FlaggedContent = ParseHelper.flagContent(post! as! Post)
//
            ParseHelper.flagContent(post as! Post)
            //flag.saveInBackgroundWithBlock(nil)
            println ("saving flag")
        }
    }
    
    @IBAction func voteButtonTapped(sender: AnyObject) {
        println("Vote button tapped")
        ParseHelper.vote(self.post!)
    }
    

}
