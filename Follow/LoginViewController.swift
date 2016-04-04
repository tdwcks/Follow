//
//  LoginViewController.swift
//  Follow
//
//  Created by Tom Wicks on 04/04/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var UserEmailTextField: UITextField!
    @IBOutlet weak var UserPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButtonTapped(sender: AnyObject) {
        
        let userEmail = UserEmailTextField.text;
        let userPassword = UserPasswordTextField.text;
        
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("UserEmail");
        
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("UserPassword");
        
        if(userEmailStored == userEmail)
        {
            if(userPasswordStored == userPassword)
            {
                // Login Succesful
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                
                self.dismissViewControllerAnimated(true, completion:nil);
            }
        }
    }
}
