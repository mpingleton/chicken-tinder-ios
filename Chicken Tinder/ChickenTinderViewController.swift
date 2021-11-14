//
//  ChickenTinderViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class ChickenTinderViewController: UIViewController, LoginDelegate, JoinSessionDelegate, CreateSessionDelegate {
    
    override func viewDidLoad() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueToLogin") {
            let dest = segue.destination as! LoginViewController
            dest.delegate = self
        }
        else if(segue.identifier == "segueToCreateSession") {
            let dest = segue.destination as! CreateSessionViewController
            dest.delegate = self
        }
        else if(segue.identifier == "segueToJoinSession") {
            let dest = segue.destination as! JoinSessionViewController
            dest.delegate = self
        }
    }
    
}
