//
//  LoginViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Delegates
    var delegate: LoginDelegate!
    
    // API
    var apiSession: CTApiSession!
    
    // User interface outlets.
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    override func viewDidLoad() {
        inputUsername.text = ""
        inputUsername.isEnabled = true
        inputPassword.text = ""
        inputPassword.isEnabled = true
        buttonLogin.isEnabled = true
        indicatorActivity.stopAnimating()
        indicatorActivity.hidesWhenStopped = true
        labelErrorMessage.text = ""
    }
    
    // User interface actions.
    @IBAction func buttonLogin_clicked(_ sender: Any) {
        
        // Update the user interface
        inputUsername.isEnabled = false
        inputPassword.isEnabled = false
        buttonLogin.isEnabled = false
        buttonLogin.isHidden = true
        indicatorActivity.startAnimating()
        labelErrorMessage.text = ""
        
        // Send the login request.
        apiSession.login(username: inputUsername.text!, passphrase: inputPassword.text!) { error in
            self.inputUsername.isEnabled = true
            self.inputPassword.isEnabled = true
            self.buttonLogin.isEnabled = true
            self.buttonLogin.isHidden = false
            self.indicatorActivity.stopAnimating()
            
            if error != nil {
                self.labelErrorMessage.text = "Incorrect username/password."
            }
            else {
                self.labelErrorMessage.text = ""
                self.delegate.successfulLogin()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
