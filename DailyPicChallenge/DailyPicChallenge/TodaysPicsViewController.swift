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
    
    var challenge: PFObject!
    
    var posts: [Post] = []
    
    
    var pic: Picture?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    static func displayAlert(alertTitle: String, alertMessage: String){
        /*
        var alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)d
        */
        let alertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    override func viewDidAppear(animated: Bool) {

        let todaysChallenge = ParseHelper.todaysChallenge().challengeObject
        challenge = todaysChallenge
        println("\(challenge)")
        let todaysChallengeString = ParseHelper.todaysChallenge().challengeString
        
        challengeLabel.text = todaysChallengeString
        
        let todaysPostsQuery = Post.query()
        
        ParseHelper.todaysPosts(todaysChallenge, todaysPostsQuery: todaysPostsQuery)
        
        todaysPostsQuery!.findObjectsInBackgroundWithBlock {
            (result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            
            for post in self.posts {
                // 2
                let data = post.imageFile?.getData()
                // 3
                post.image = UIImage(data: data!, scale:1.0)
            }

            // 9
            self.tableView.reloadData()
            
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
                let imageData = UIImageJPEGRepresentation(image, 0.8)
                let imageFile = PFFile(data: imageData)
                imageFile.saveInBackgroundWithBlock(nil)
            
                let post = Post()
                post.image = image
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
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        
        cell.postImageView.image = posts[indexPath.row].image
        
        return cell
    }
    
}
