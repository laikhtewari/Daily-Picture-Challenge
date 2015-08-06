//
//  LoginViewController.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/6/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getStartedButtonTapped (sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text) { (user: PFUser?, error: NSError?) -> Void in
            if let user = user
            {
                self.performSegueWithIdentifier("loggedIn", sender: self.getStartedButton)
            }
            else if let error = error
            {
                let alertView = UIAlertView(title: "Error", message: "Username or password incorrect", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
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
