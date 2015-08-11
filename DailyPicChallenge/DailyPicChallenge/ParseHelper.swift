//
//  ParseHelper.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/24/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import Foundation
import Parse
import Mixpanel

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
            return ("No Challenge", nil)
        }
    }
    
    static func todaysPosts ( todaysChallenge: PFObject?, todaysPostsQuery: PFQuery? )
    {
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
    
    static func addChallengeToPost ( post: Post, challenge: PFObject )
    {
        let localChallenge = challenge as! Challenge
        post.challenge = localChallenge
        
    }
    
    static func addChallengeToPost( post: PFObject, challenge: PFObject)
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
            toPost.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                println("total vote count updated")
            })
        }
        
//        let postsQuery = Post.query()
//        postsQuery?.whereKey("fromUser", equalTo: currentUser)
//        postsQuery?.countObjectsInBackgroundWithBlock({ (num: Int32, error: NSError?) -> Void in
//            if num != 0
//            {
//                Mixpanel.track(Mixpanel)
//            }
//        })
    }
    
    static func unvote ( fromUser: PFUser, toPost: PFObject)
    {
        let voteQuery = Vote.query()
        voteQuery?.whereKey("fromUser", equalTo: fromUser)
        voteQuery?.whereKey("toPost", equalTo: toPost)
        
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
    
    static func timelineRequestforCurrentUser( completionBlock: PFArrayResultBlock) {
//        let followingQuery = PFQuery(className: ParseFollowClass)
//        followingQuery.whereKey(ParseLikeFromUser, equalTo:PFUser.currentUser()!)
//        
//        let postsFromFollowedUsers = Post.query()
//        postsFromFollowedUsers!.whereKey(ParsePostUser, matchesKey: ParseFollowToUser, inQuery: followingQuery)
//        
//        let postsFromThisUser = Post.query()
//        postsFromThisUser!.whereKey(ParsePostUser, equalTo: PFUser.currentUser()!)
//        
//        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
//        query.includeKey(ParsePostUser)
//        query.orderByDescending(ParsePostCreatedAt)
//        
//        query.skip = range.startIndex
//        query.limit = range.endIndex - range.startIndex
//        
//        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        
        let todaysChallenge = ParseHelper.todaysChallenge().challengeObject
        let challenge = todaysChallenge
        
        let todaysPostsQuery = Post.query()
        
        ParseHelper.todaysPosts(todaysChallenge, todaysPostsQuery: todaysPostsQuery)
        
        todaysPostsQuery!.findObjectsInBackgroundWithBlock(completionBlock)
            
//            {
//            (result: [AnyObject]?, error: NSError?) -> Void in
//            // 8
//            self.posts = result as? [Post] ?? []
//            
//            for post in self.posts {
//                // 2
//                let data = post.imageFile?.getData()
//                // 3
//                post.image.value = UIImage(data: data!, scale:1.0)
//            }
        
            // 9
//            self.tableView.reloadData()
        
//        }
        
    }
    
    static func winnerPostsRequest ( completionBlock: PFArrayResultBlock )
    {
        let postQuery = Post.query()
        postQuery?.whereKey("winner", equalTo: true)
        
        postQuery?.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    static func getInfoWithPost ( post: Post ) -> (challenge: String, username: String)    {
//        let postObject = post as PFObject
//        var challengeObject = postObject["challenge"] as! PFObject
//        let challengeQuery = Challenge.query()
//        challengeObject = challengeQuery?.getObjectWithId(challengeObject.objectId!)
//        let challengeString = challengeObject["challenge"] as! String
//        let objectID = challengeObject.objectId
//        let challengeQuery = Challenge.query()
//        let object = challengeQuery?.getObjectWithId(objectID)
//        return (challengeString, challengeObject)
        
//        let parsePost = post as PFObject
//        let challengeObject = parsePost["challenge"] as! PFObject
//        let challengeString = challengeObject["challenge"] as! String
//        let challenge = parsePost["challenge"] as! Challenge
//        let challengeString = challenge.challenge
        
        let image = post.imageFile
        let postQuery = Post.query()
        postQuery?.whereKey("imageFile", equalTo: image!)
        
        let list = postQuery!.findObjects()
        let post = list?.first as! PFObject
        let challenge = post["challenge"] as! PFObject
        let user = post["fromUser"] as! PFUser
        let username = user.username
        let challengeID = challenge.objectId
        
        let challengeQuery = Challenge.query()
        let challengeObject = challengeQuery?.getObjectWithId(challengeID!) as! Challenge
        let challengeString = challengeObject.challenge
        
        return (challengeString, username!)
        
    }
}