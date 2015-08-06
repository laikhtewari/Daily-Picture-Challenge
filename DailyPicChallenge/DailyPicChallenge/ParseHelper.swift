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
        println("this method was called")
        if let challengeObject = todaysChallenge
        {
            todaysPostsQuery?.whereKey("challenge", equalTo: challengeObject)
            
//            let flaggedPostsQuery = FlaggedContent.query()
//            flaggedPostsQuery?.whereKey("objectId", notEqualTo: "")
//            
//            println("flagged posts query: \(flaggedPostsQuery)")
//            
//            println("STARTING FILTER OF POSTS")
//            todaysPostsQuery?.whereKey("objectId", doesNotMatchKey: "toPost", inQuery: flaggedPostsQuery!)
            
            todaysPostsQuery?.whereKeyDoesNotExist("flag")
            
            todaysPostsQuery!.orderByDescending("createdAt")
        }
    }
    
    static func addChallengeToPost ( post: PFObject, challenge: PFObject )
    {
        post["challenge"] = challenge
    }
    
    static func vote ( toPost: Post )
    {
        let userVote = Vote.query()
        let currentUser = PFUser.currentUser()
        
        userVote?.whereKey("fromUser", equalTo: currentUser!)
        
        let count = userVote?.countObjects()
        
//        userVote.findObjectsInBackgroundWithBlock {
//            (results: AnyObject?, error: NSError?) -> Void in
//            
//            if let vote = results as? Vote
//            {
//                vote.deleteInBackgroundWithBlock(nil)
//            }
//        }
        
        if count != 0 {
            let voteObject = userVote?.getFirstObject()
            voteObject?.deleteInBackgroundWithBlock(nil)
        }
        
        let vote = Vote()
        vote.toPost = toPost
        vote.fromUser = currentUser
        vote.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            let counterQuery = Vote.query()
            counterQuery?.whereKey("toPost", equalTo: toPost as PFObject)
            let numVotes = counterQuery?.countObjects()
            toPost.totalVoteValue = count!
            toPost.saveInBackgroundWithBlock(nil)
        }
    }
    
    static func unvote ( fromUser: PFUser, toPost: PFObject)
    {
        let voteQuery = Vote.query()
        voteQuery?.whereKey("fromUser", equalTo: fromUser)
        voteQuery?.whereKey("toPicture", equalTo: toPost)
        
        voteQuery!.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]?, error: NSError?) -> Void in
            // 2
            if let results = results as? [PFObject] {
                for votes in results {
                    votes.deleteInBackgroundWithBlock(nil)
                }
            }
        }
    }
    
    static func flagContent ( toPost: Post )  {
        var flag = FlaggedContent()
        flag.fromUser = PFUser.currentUser()
        flag.toPost = toPost
        //flag.setPost(toPost)
        println("Post: \(flag.toPost)")
        toPost.flag = flag
        
        toPost.saveInBackgroundWithBlock(nil)
        flag.saveInBackgroundWithBlock(nil)
        TodaysPicsViewController.displayAlert("Thank you", alertMessage: "We appreciate you taking the time to flag inappropriate content. This post will be blocked until we review the content in question. Please look at our community guidelines for more information about flagging inappropriate content. We will get back to you as soon as possible and we will take appropriate action.")
        
        //return flag
    }
    
    static func getWinner ( challenge: Challenge ) /*-> Post*/ {
        
        //        var votedPost: Post!
        //        let posts = Post.query()
        //        let todaysChallenge = self.todaysChallenge().challengeObject
        //        posts?.whereKey("challenge", equalTo: todaysChallenge!)
        //
        //        posts!.findObjectsInBackgroundWithBlock {
        //            ( results: [AnyObject]?, error: NSError? ) -> Void in
        //
        //            if let postArray = results as? [Post]
        //            {
        //                var numVotes = 0
        //                var count = 0
        //                for posts in postArray
        //                {
        //                    count++
        //                    println("Reps = \(count)")
        //                    let thisPostsVotes = posts.totalVoteValue
        //                    if thisPostsVotes > numVotes
        //                    {
        //                        votedPost = posts
        //                        numVotes = thisPostsVotes
        //                    }
        //                }
        //            }
        //        }
        //        return votedPost
    }
    
    static func getWinner ( objectId: String ) -> Winner
    {
        let postQuery = Post.query()
        postQuery?.whereKey("objectId", equalTo: objectId)
        let winnerPost = postQuery?.getFirstObject() as! Post
        let todaysChallenge = ParseHelper.todaysChallenge().challengeObject
        let winner = Winner()
        winner.user = winnerPost.user
        winner.post = winnerPost
        winner.challenge = todaysChallenge as! Challenge
        
        winner.saveInBackgroundWithBlock(nil)
        
        return winner
    }
}