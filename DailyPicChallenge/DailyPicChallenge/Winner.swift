//
//  Winner.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/4/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class Winner: PFObject, PFSubclassing {
    
    @NSManaged var user: PFUser!
    @NSManaged var post: Post!
    @NSManaged var challenge: Challenge!
    
    static func parseClassName() -> String {
        return "Winner"
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
    
}
