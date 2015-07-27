//
//  ParseHelper.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/24/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    static func todaysChallenge () -> ( challengeString: String?, challengeObject: PFObject?)
    {
        let challengeQuery = Challenge.query()
        let currentDate = NSDate()
        challengeQuery?.whereKey("endDate", greaterThanOrEqualTo: currentDate)
        challengeQuery?.whereKey("startDate", lessThanOrEqualTo: currentDate)
        let todaysChallenge = challengeQuery?.getFirstObject()
        let todaysChallengeString: String!
        println ("\(todaysChallenge)")
        
        if let challengeObject = todaysChallenge
        {
            todaysChallengeString = challengeObject["challenge"] as! String
            return (todaysChallengeString, todaysChallenge)
        } else {
            TodaysPicsViewController.displayAlert("Error", alertMessage: "Unable to retrieve today's challenge")
            return ("No Challenge", todaysChallenge)
        }
    }
    
    static func todaysPosts ( todaysChallenge: PFObject?, todaysPostsQuery: PFQuery? )
    {
        if let challengeObject = todaysChallenge
        {
            todaysPostsQuery?.whereKey("challenge", equalTo: challengeObject)
            
            todaysPostsQuery!.orderByDescending("createdAt")
        }
    }
}