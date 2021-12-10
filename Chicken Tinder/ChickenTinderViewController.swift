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
    @IBOutlet weak var imageRestaurant: UIImageView!
    @IBOutlet weak var labelRestaurantName: UILabel!
    @IBOutlet weak var labelRestaurantLocation: UILabel!
    @IBOutlet weak var buttonPass: UIButton!
    @IBOutlet weak var buttonLike: UIButton!
    
    override func viewDidLoad() {
        
        if apiSession.accessToken.isEmpty {
            performSegue(withIdentifier: "segueToLogin", sender: self)
        }
        
        imageRestaurant.isHidden = true
        labelRestaurantName.text="Texas Roadhouse"
        labelRestaurantLocation.text="Shreveport, LA"
        
        let imageUrl = URL(string: "https://cdn.vox-cdn.com/thumbor/Om_vzCuDw_nMBs6RDOlYdHfpApQ=/0x0:1000x439/1200x800/filters:focal(421x92:581x252)/cdn.vox-cdn.com/uploads/chorus_image/image/66890945/Texas_Roadhouse.0.jpg")!
        if let data = try? Data(contentsOf: imageUrl) {
            imageRestaurant.image = UIImage(data: data)
            imageRestaurant.isHidden = false
        }
        
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
        apiSession.getAllRestaurants() { error in
            if self.apiSession.restaurantStack.count > 0 {
                self.labelRestaurantName.text = self.apiSession.restaurantStack.first?.name
                self.labelRestaurantLocation.text = self.apiSession.restaurantStack.first?.location
            }
        }
    }
    
    // User interface actions.
    @IBAction func buttonPass_clicked(_ sender: Any) {
        apiSession.restaurantStack.removeFirst()
        labelRestaurantName.text = apiSession.restaurantStack.first?.name
        labelRestaurantLocation.text = apiSession.restaurantStack.first?.location
    }
    
    @IBAction func buttonLike_clicked(_ sender: Any) {
    }
    
}
