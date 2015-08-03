//
//  FlaggedContent.swift
//  
//
//  Created by Laikh Tewari on 7/31/15.
//
//

import UIKit
import Parse

class FlaggedContent: PFObject, PFSubclassing {
    
    @NSManaged var fromUser: PFUser! //= //PFUser.currentUser()
   @NSManaged var toPost: Post!
    
    static func parseClassName() -> String {
        return "FlaggedContent"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
//    func setPost ( post: Post )
//    {
//        toPost = post
//    }
}
