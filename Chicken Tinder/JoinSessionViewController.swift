//
//  JoinSessionViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class JoinSessionViewController: UIViewController {
    
    // Delegates
    var delegate: JoinSessionDelegate!
    
    // API
    var apiSession: CTApiSession!
    
    // User interface outlets.
    @IBOutlet weak var inputSessionCode: UITextField!
    @IBOutlet weak var buttonJoin: UIButton!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func buttonJoin_clicked(_ sender: Any) {
    }
    
}
