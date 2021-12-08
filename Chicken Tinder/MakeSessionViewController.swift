//
//  MakeSessionViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 12/7/21.
//

import UIKit

class MakeSessionViewController: UIViewController {
    
    // Delegates
    var delegate: MakeSessionDelegate!
    
    // API
    var apiSession: CTApiSession!
    
    // User interface outlets.
    @IBOutlet weak var tabSelector: UISegmentedControl!
    @IBOutlet weak var tabCreate: UIStackView!
    @IBOutlet weak var tabJoin: UIStackView!
    @IBOutlet weak var inputLocation: UITextField!
    @IBOutlet weak var inputJoinCode: UITextField!
    
    override func viewDidLoad() {
        tabSelector.selectedSegmentIndex = 0
        tabCreate.isHidden = false
        tabJoin.isHidden = true
    }
    
    // User interface actions.
    @IBAction func tabSelector_changed(_ sender: Any) {
        switch tabSelector.selectedSegmentIndex {
        case 0:
            tabCreate.isHidden = false
            tabJoin.isHidden = true
        case 1:
            tabCreate.isHidden = true
            tabJoin.isHidden = false
        default:
            tabCreate.isHidden = false
            tabJoin.isHidden = false
        }
    }
    
    @IBAction func btnCreate_clicked(_ sender: Any) {
    }
    
    @IBAction func btnJoin_clicked(_ sender: Any) {
    }
    
    
}
