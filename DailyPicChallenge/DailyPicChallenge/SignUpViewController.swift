//
//  SignUpViewController.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/6/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getStartedTapped(sender: AnyObject) {
//        let userQuery = PFQuery(className: "User")
//        var usernameArray: [String]!
//        
//        userQuery.findObjectsInBackgroundWithBlock {
//            (results: [AnyObject]?, error: NSError?) -> Void in
//            
//            let userArray = results as? [PFUser] ?? []
//            
//            for user in userArray
//            {
//                usernameArray.append(user.username!)
//            }
//        }
//        
//        if let username = self.usernameField.text
//        {
//            var contained = false
//            for obj in usernameArray
//            {
//                if obj == username
//                {
//                    contained = true
//                }
//            }
//            if contained == false
//            {
//                self.T
//            }
//        }

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
