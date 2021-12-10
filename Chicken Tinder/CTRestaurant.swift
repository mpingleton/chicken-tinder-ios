//
//  CTRestaurant.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 12/9/21.
//

class CTRestaurant {
    
    var id = 0
    var name = ""
    var location = ""
    
    init() {}
    
    init(withId: Int, withName: String, withLocation: String) {
        id = withId
        name = withName
        location = withLocation
    }
}
