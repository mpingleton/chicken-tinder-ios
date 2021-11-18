//
//  ChickenTinderViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class ChickenTinderViewController: UIViewController, LoginDelegate, JoinSessionDelegate, CreateSessionDelegate {
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var labelRestaurantName: UILabel!
    @IBOutlet weak var labelRestaurantLocation: UILabel!
    @IBOutlet weak var buttonPass: UIButton!
    @IBOutlet weak var buttonLike: UIButton!
    
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
    
    @IBAction func buttonPass_clicked(_ sender: Any) {
    }
    
    @IBAction func buttonLike_clicked(_ sender: Any) {
    }
    
}
