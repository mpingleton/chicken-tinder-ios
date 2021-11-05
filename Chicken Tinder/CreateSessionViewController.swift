//
//  CreateSessionViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class CreateSessionViewController: UIViewController {
    
    // Delegates.
    var delegate: CreateSessionDelegate!
    
    // User interface outlets.
    @IBOutlet weak var inputLatitude: UITextField!
    @IBOutlet weak var inputLongitude: UITextField!
    @IBOutlet weak var buttonSetLocation: UIButton!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var sliderDistance: UISlider!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func buttonSetLocation_clicked(_ sender: Any) {
    }
    
    @IBAction func sliderDistance_changed(_ sender: Any) {
    }
    
}
