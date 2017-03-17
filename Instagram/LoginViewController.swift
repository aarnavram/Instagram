//
//  LoginViewController.swift
//  Instagram
//
//  Created by Aarnav Ram on 16/03/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignInPressed(_ sender: Any) {
    }
    
    @IBAction func onSignUpPressed(_ sender: Any) {
        
        var newUser = PFUser()
        
        newUser.username = self.usernameField.text!
        newUser.password = self.passwordField.text!
        print(newUser.username)
        print(newUser.password)
        
        newUser.signUpInBackground { (bool: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.alertMessage(title: "Congratulations", string: "Now Login")
            }
        }
        
        if let usernameField = usernameField {
            if usernameField.text! != "" {
                if let passwordTextField = passwordField {
                    if passwordTextField.text! == "" {
                        usernameField.endEditing(true)
                        passwordTextField.endEditing(true)
                        alertMessage(title: "Missing",string: "Please enter a password")
                    } else {
                        newUser.username = usernameField.text!
                        newUser.password = passwordField.text!
                        
                        newUser.signUpInBackground(block: { (succeeded: Bool, error: Error?) in
                            if let error = error {
                                print(error)
                            } else {
                                self.usernameField.endEditing(true)
                                self.passwordField.endEditing(true)
                                self.performSegue(withIdentifier: "toMainPage", sender: nil)
                            }
                        })
                    }
                }
                print(usernameField.text!)
            } else {
                usernameField.endEditing(true)
                passwordField.endEditing(true)
                alertMessage(title: "Missing", string: "Please enter an email address")
                if let passwordTextField = passwordField {
                    if passwordTextField.text! != "" {
                        self.usernameField.endEditing(true)
                        self.passwordField.endEditing(true)
                        alertMessage(title: "Missing",string: "Please enter a password")
                    }
                    
                }
                
            }
        }
        
    
        
        
    }
    
    func alertMessage(title:String, string: String) {
        let alertController = UIAlertController(title: title, message: string, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //dismiss it
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true) {
            //dismiss it
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
