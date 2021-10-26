//
//  ChickenTinderViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class ChickenTinderViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "segueToLogin", sender: self)
    }
    
    @IBAction func createBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "segueToCreateSession", sender: self)
    }
    
    @IBAction func joinBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "segueToJoinSession", sender: self)
    }
    
}
