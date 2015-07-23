
//
//  Post.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/23/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    var image: UIImage?
    
    
    static func parseClassName() -> String {
        return "Post"
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
    
//    func uploadPost ()
//    {
//
//        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
//        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
//        dispatch_async(backgroundQueue, {
//            let imageData = UIImageJPEGRepresentation(self.image, 0.8)
//            let imageFile = PFFile(data: imageData )
//            self.photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
//                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
//            }
//            
//            imageFile.saveInBackgroundWithBlock(nil)
//            
//            user = PFUser.currentUser()
//        
//            self.imageFile = imageFile
//            self.saveInBackgroundWithBlock(nil)
//            
//        })
//    }
    
    func uploadPost ()
    {
        let imageData = UIImageJPEGRepresentation(self.image, 0.8)
        let imageFile = PFFile(data: imageData )
        self.photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
        imageFile.saveInBackgroundWithBlock(nil)
            
        user = PFUser.currentUser()
            
        self.imageFile = imageFile
        self.saveInBackgroundWithBlock(nil)
    }
    
}