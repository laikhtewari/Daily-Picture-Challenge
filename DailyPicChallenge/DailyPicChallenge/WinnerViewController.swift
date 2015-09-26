//
//  WinnerViewController.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/4/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class WinnerViewController: UIViewController {

    @IBOutlet weak var winnerTableView: UITableView!
    
    var winnerPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.winnerTableView.dataSource = self
        
        ParseHelper.winnerPostsRequest { (results: [AnyObject]?, error: NSError?) -> Void in
            self.winnerPosts = results as? [Post] ?? []
            
            self.winnerTableView.reloadData()
            
            println("NUMBER OF WINNERS: \(self.winnerPosts.count)")
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        postQuery!.findObjectsInBackgroundWithBlock {
//            (result: [AnyObject]?, error: NSError?) -> Void in
//            // 8
//            self.winnerPosts = result as? [Post] ?? []
//            println("NUMBER OF OBJECTS: \(self.winnerPosts.count)")
//            for post in self.winnerPosts {
//                // 2
//                let data = post.imageFile?.getData()
//                // 3
//                post.image.value = UIImage(data: data!, scale:0.8)
//            }
//            
//            self.winnerTableView.reloadData()
//        }
        
        
//        let winnersQuery = Winner.query()
//        
//        winnersQuery!.findObjectsInBackgroundWithBlock {
//            (results: [AnyObject]?, error: NSError?) -> Void in
//            
//            self.winners = results as? [Winner] ?? []
//            
//            for winner in self.winners
//            {
//                let data = winner.post.imageFile?.getData()
//                
//                winner.post.image = UIImage(data: data!, scale: 1.0)
//            }
//            
//            winnersQuery?.orderByDescending("createdAt")
//            
//            self.winnerTableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logoutTapped(sender: AnyObject) {
        println("LOGOUTBUTTONTAPPED")
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if let error = error
            {
                let alertView = UIAlertView(title: "Error", message: "Unable to logout", delegate: nil, cancelButtonTitle: "OK")
            }
            else
            {
                self.performSegueWithIdentifier("LoggedOut", sender: self)
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.removeObjectForKey("username")
                defaults.removeObjectForKey("password")
                println("\(PFUser.currentUser())")
            }
        }
    }

}

extension WinnerViewController: UITableViewDataSource {
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return winnerPosts.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = winnerTableView.dequeueReusableCellWithIdentifier("WinnerCell") as! WinnerTableViewCell
        
        let post = winnerPosts[indexPath.row]
        
        post.downloadImage()
        
        cell.winnerPost = post
        
        cell.setChallenge()
        //cell.winnerImageView.image = winnerPosts[indexPath.row].image
        
        cell.challengeLabel.text = "Noble Statues"
        cell.userLabel.text = "andrewJames123"
        
        return cell
    }
}

