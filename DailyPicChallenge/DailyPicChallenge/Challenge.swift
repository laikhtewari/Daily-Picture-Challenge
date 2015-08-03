//
//  Challenge.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/24/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class Challenge: PFObject, PFSubclassing {
    
    var challenge: String!
    
    static func parseClassName() -> String {
        return "Challenges"
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
    
    func createChallenge ( challenge: String )
    {
        self.challenge = challenge
        self.saveInBackgroundWithBlock(nil)
    }
   
}
