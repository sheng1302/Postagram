//
//  LoginViewController.swift
//  Postagram
//
//  Created by Sheng Liu on 3/17/19.
//  Copyright © 2019 Sheng Liu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onTapSignUp(_ sender: Any) {
        let username = self.usernameField.text!
        let password = self.passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){
            (user,error) in
            if(user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Error \(error)")
            }
            
        }
        
    }
    @IBAction func onTapSignIn(_ sender: Any) {
        let user = PFUser()
        user.username = self.usernameField.text
        user.password = self.passwordField.text

        
        user.signUpInBackground{ (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print(success)
            } else{
                print("Error \(error)")
            }
            
        }

    }


}
