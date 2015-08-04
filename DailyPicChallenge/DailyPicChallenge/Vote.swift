//
//  Vote.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/27/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class Vote: PFObject, PFSubclassing {

    @NSManaged var toPost: Post!
    @NSManaged var fromUser: PFUser!
    
    static func parseClassName() -> String {
        return "Vote"
    }
    
    override init ()
    {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}
