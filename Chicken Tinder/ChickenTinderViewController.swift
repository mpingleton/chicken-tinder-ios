//
//  ChickenTinderViewController.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 10/26/21.
//

import UIKit

class ChickenTinderViewController: UIViewController, LoginDelegate, MakeSessionDelegate {
    
    // Data and state.
    let apiSession = CTApiSession()
    
    // User interface outlets.
    @IBOutlet weak var viewRestaurant: UIView!
    @IBOutlet weak var viewButtons: UIStackView!
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var labelRestaurantName: UILabel!
    @IBOutlet weak var labelRestaurantLocation: UILabel!
    @IBOutlet weak var buttonPass: UIButton!
    @IBOutlet weak var buttonLike: UIButton!
    
    override func viewDidLoad() {
        
        // If we are not logged in, prompt the user to log in.
        if apiSession.accessToken.isEmpty {
            performSegue(withIdentifier: "segueToLogin", sender: self)
        }
        
        viewRestaurant.isHidden = true
        viewButtons.isHidden = true
        imageRestaurant.isHidden = true
        labelRestaurantName.text=""
        labelRestaurantLocation.text=""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToLogin" {
            let dest = segue.destination as! LoginViewController
            dest.delegate = self
            dest.apiSession = apiSession
        }
        else if segue.identifier == "segueToMakeSession" {
            let dest = segue.destination as! MakeSessionViewController
            dest.delegate = self
            dest.apiSession = apiSession
        }
    }
    
    func successfulLogin() {
        performSegue(withIdentifier: "segueToMakeSession", sender: self)
    }
    
    func sessionMade() {
        apiSession.getAllRestaurants() { error in
            if self.apiSession.restaurantStack.count > 0 {
                self.viewRestaurant.isHidden = false
                self.viewButtons.isHidden = false
                self.labelRestaurantName.text = self.apiSession.restaurantStack.first?.name
                self.labelRestaurantLocation.text = self.apiSession.restaurantStack.first?.location
                self.imageRestaurant.image = self.apiSession.restaurantStack.first?.images.first?.image
                self.imageRestaurant.isHidden = false
            }
            else {
                self.viewRestaurant.isHidden = true
                self.viewButtons.isHidden = true
                self.labelRestaurantName.text = ""
                self.labelRestaurantLocation.text = ""
                self.imageRestaurant.isHidden = true
            }
        }
    }
    
    // User interface actions.
    @IBAction func buttonPass_clicked(_ sender: Any) {
        apiSession.restaurantStack.removeFirst()
        if self.apiSession.restaurantStack.count > 0 {
            self.viewRestaurant.isHidden = false
            self.viewButtons.isHidden = false
            self.labelRestaurantName.text = self.apiSession.restaurantStack.first?.name
            self.labelRestaurantLocation.text = self.apiSession.restaurantStack.first?.location
            self.imageRestaurant.image = self.apiSession.restaurantStack.first?.images.first?.image
            self.imageRestaurant.isHidden = false
        }
        else {
            self.viewRestaurant.isHidden = true
            self.viewButtons.isHidden = true
            self.labelRestaurantName.text = ""
            self.labelRestaurantLocation.text = ""
            self.imageRestaurant.isHidden = true
        }
    }
    
    @IBAction func buttonLike_clicked(_ sender: Any) {
        apiSession.enterLike(restaurantId: apiSession.restaurantStack.first!.id) { error in
            if error != nil {
                print("Error submitting like: \(error!)")
            }
        }
        apiSession.restaurantStack.removeFirst()
        if self.apiSession.restaurantStack.count > 0 {
            self.viewRestaurant.isHidden = false
            self.viewButtons.isHidden = false
            self.labelRestaurantName.text = self.apiSession.restaurantStack.first?.name
            self.labelRestaurantLocation.text = self.apiSession.restaurantStack.first?.location
            self.imageRestaurant.image = self.apiSession.restaurantStack.first?.images.first?.image
            self.imageRestaurant.isHidden = false
        }
        else {
            self.viewRestaurant.isHidden = true
            self.viewButtons.isHidden = true
            self.labelRestaurantName.text = ""
            self.labelRestaurantLocation.text = ""
            self.imageRestaurant.isHidden = true
        }
    }
    
}
