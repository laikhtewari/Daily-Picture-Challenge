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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        self.checkExternalTaps()
        
        activityIndicator.hidesWhenStopped = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.frame.origin.y = 0;
        super.viewDidAppear(true)
        if let user = PFUser.currentUser()
        {
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.frame.origin.y = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getStartedButtonTapped (sender: AnyObject) {
        activityIndicator.startAnimating()
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text) { (user: PFUser?, error: NSError?) -> Void in
            self.activityIndicator.stopAnimating()
            if let user = user
            {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject( self.usernameField.text, forKey: "username")
                defaults.setObject(self.passwordField.text, forKey: "password")
                self.performSegueWithIdentifier("loggedIn", sender: self.getStartedButton)
            }
            else if let error = error
            {
                let alertView = UIAlertView(title: "Error", message: "Username or password incorrect", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if(self.view.frame.origin.y > -150) {
                self.view.frame.origin.y -= 150
            }
        })
    }
    func keyboardWillHide(sender: NSNotification) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if (self.view.frame.origin.y < 150) {
                self.view.frame.origin.y += 150
            }
        })
    }
    
    func checkExternalTaps(){
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
}
