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
            
        }
        else if(segue.identifier == "segueToCreateSession") {
            
        }
        else if(segue.identifier == "segueToJoinSession") {
            
        }
    }
    
}
