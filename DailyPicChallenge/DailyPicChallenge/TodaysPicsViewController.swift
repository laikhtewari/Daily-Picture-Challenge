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
    
    var posts: [Post] = []
    
    
    var pic: Picture?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let challengeQuery = Challenge.query()
        let currentDate = NSDate()
        challengeQuery?.whereKey("endDate", greaterThanOrEqualTo: currentDate)
        challengeQuery?.whereKey("startDate", lessThanOrEqualTo: currentDate)
        let todaysChallenge = challengeQuery?.getFirstObject()
        let todaysChallengeString = todaysChallenge!["challenge"] as! String
        
        println(todaysChallengeString)
        
        challengeLabel.text = todaysChallengeString
        
        //let todaysChallengeID = todaysChallenge?.objectId
        
        let todaysPostsQuery = Post.query()
        todaysPostsQuery?.whereKey("challenge", equalTo: todaysChallenge!)
        
        todaysPostsQuery!.orderByDescending("createdAt")
        
        todaysPostsQuery!.findObjectsInBackgroundWithBlock {
            (result: [AnyObject]?, error: NSError?) -> Void in
            // 8
            self.posts = result as? [Post] ?? []
            // 9
            self.tableView.reloadData()
            
            println("set table view with place holders")
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo  is selected
        pic = Picture(viewController: self.tabBarController!, callback: { (image: UIImage?) in
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let imageFile = PFFile(data: imageData)
            imageFile.saveInBackgroundWithBlock(nil)
            
            let post = Post()
            post.image = image
            post.uploadPost()
        })
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
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! UITableViewCell
        
        cell.textLabel!.text = "Post"
        
        return cell
    }
    
}
