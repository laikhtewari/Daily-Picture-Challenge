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
    
    @IBAction func hideUsernameTextWhenTapped(sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func hideEmailTextWhenTapped(sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func hidePasswordTextWhenTapped(sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func hideConfirmPasswordTextWhenTapped(sender: UITextField) {
        sender.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getStartedTapped(sender: AnyObject) {
        let userQuery = PFUser.query()
        userQuery?.whereKey("username", equalTo: usernameField.text)
        userQuery?.findObjectsInBackgroundWithBlock {
            (results:[AnyObject]?, error: NSError?) -> Void in
            if results?.count == 0
            {
                if self.passwordField.text == self.confirmPasswordField.text
                {
                    let user = PFUser()
                    user.username = self.usernameField.text
                    user.password = self.passwordField.text
                    user.email = self.emailField.text
                    
                    user.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        
                        if let error = error
                        {
                            let alertView = UIAlertView(title: "Error", message: "Unable to sign up", delegate: nil, cancelButtonTitle: "OK")
                            alertView.show()
                        }
                        else
                        {
                            println("done saving")
                            PFUser.logInWithUsernameInBackground(self.usernameField.text, password: self.passwordField.text, block: { (user: PFUser?, error: NSError?) -> Void in
                                if let error = error
                                {
                                    let alertView = UIAlertView(title: "Error", message: "Unsuccessful login", delegate: nil, cancelButtonTitle: "OK")
                                    alertView.show()
                                }
                                else
                                {
                                    println("logged in successfully")
                                    self.performSegueWithIdentifier("signedUp", sender: self)
                                }
                            })
                        }
                    })
                }
                else
                {
                    let alertView = UIAlertView(title: "Error", message: "Passwords do not match", delegate: nil, cancelButtonTitle: "OK")
                    alertView.show()
                }
            }
            else
            {
                let alertView = UIAlertView(title: "Error", message: "Username already taken", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
    }
}
