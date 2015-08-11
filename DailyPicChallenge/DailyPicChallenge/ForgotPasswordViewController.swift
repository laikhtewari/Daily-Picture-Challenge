//
//  ForgotPasswordViewController.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/9/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class ForgotPasswordViewController: UIViewController {
    
    var edited = false;

    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendEmail ()
    {
        PFUser.requestPasswordResetForEmailInBackground(emailField.text, block: {
            (success: Bool, error: NSError?) -> Void in
            if let error = error
            {
                let alertView = UIAlertView(title: "Error", message: "Unable to send reset email", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
            
            else if success == true
            {
                let alertView = UIAlertView(title: "Success", message: "We have sent you a link to reset your password", delegate: nil, cancelButtonTitle: "OK")
                alertView.show()
            }
       })
    }
    
    @IBAction func enterTapped(sender: AnyObject) {
        sendEmail()
    }
//
//    @IBAction func touchOutside(sender: AnyObject) {
//        if edited
//        {
//            sendEmail()
//        }
//    }
//    
//    
//    @IBAction func editingDidEnd(sender: AnyObject) {
//        sendEmail()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
