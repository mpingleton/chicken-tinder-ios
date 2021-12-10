//
//  CTRestaurantImage.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 12/10/21.
//

import Foundation
import UIKit

class CTRestaurantImage {
    
    var url = ""
    var image: UIImage!
    
    init() {}
    
    init(withUrl: String) {
        url = withUrl
        downloadImage()
    }
    
    func downloadImage() {
        let imageUrl = URL(string: url)!
        let data = try! Data(contentsOf: imageUrl)
        image = UIImage(data: data)
    }
}
