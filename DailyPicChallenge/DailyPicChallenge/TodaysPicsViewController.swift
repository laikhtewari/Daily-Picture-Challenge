//
//  TodaysPicsViewController.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 7/20/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class TodaysPicsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var challengeLabel: UILabel!
    
    
    var flagSelected = false
    
    var memoryWarningCount = 0
    
    var challenge: PFObject!
    
    var posts: [Post] = []
    
    
    var pic: Picture?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.tableView.dataSource = self
        
    }
    
    static func displayAlert(alertTitle: String, alertMessage: String){
        let alertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //running on main thread :(
        
        let challengeDictionary = ParseHelper.todaysChallenge()
        let challengeObject = challengeDictionary.challengeObject
        let challengeString = challengeDictionary.challengeString
        
        if let challenge = challengeObject
        {
            self.challenge = challengeObject
        }
        
        challengeLabel.text = challengeString
        
        ParseHelper.timelineRequestforCurrentUser { (results: [AnyObject]?, error: NSError?) -> Void in
            if let error = error
            {
                println("error querying challenges")
            }
            else
            {
                self.posts = results as? [Post] ?? []
                
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo  is selected
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear))
        {
            pic = Picture(viewController: self.tabBarController!, callback: { (image: UIImage?) in
                let imageData = UIImageJPEGRepresentation(image, 0.5)
                let imageFile = PFFile(data: imageData)
                imageFile.saveInBackgroundWithBlock(nil)
            
                let post = Post()
                post.image.value = image!
                let pfPost = post as PFObject
                ParseHelper.addChallengeToPost(pfPost, challenge: self.challenge)
                post.uploadPost()
                
                self.tableView.reloadData()
            })
        }
        
        else {
            let alertView = UIAlertView(title: "Error", message: "Camera unavailable", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
            // don't do anything, yet...
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension TodaysPicsViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is CameraViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
    
}

extension TodaysPicsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        println("\(posts.count)")
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        let post = posts[indexPath.row]
        
        post.downloadImage()
        
        cell.post = post
        
        //cell.postImageView.image = posts[indexPath.row].image.value
        //cell.post = posts[indexPath.row]
        
        return cell
    }
}
