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
    
    // User interface outlets.
    @IBOutlet weak var inputUsername: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func buttonLogin_clicked(_ sender: Any) {
    }
    
}
