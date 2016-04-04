//
//  RegisterPageViewController.swift
//  Follow
//
//  Created by Tom Wicks on 04/04/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {
    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        
        // Check for Empty Fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty)
        {
            // Display alert message and return
            
            displayMyAlertMessage("All Fields are required");
            return;
        }
        
        // Check if passwords match
        
        if(userPassword != userRepeatPassword) {
            
            displayMyAlertMessage("Passwords don't match!");
            return;
        }
        
        // Store data
        
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey : "UserEmail")
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey : "UserPassword")
        NSUserDefaults.standardUserDefaults().synchronize();
        
        // Display alert message with confirmation
        
        var myAlert = UIAlertController(title:"Wooo", message:"You're all signed up!", preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion: nil)
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        var myAlert = UIAlertController(title:"Oops", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default, handler:nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
    }
}
