//
//  CTApiSession.swift
//  Chicken Tinder
//
//  Created by Michael Pingleton on 12/6/21.
//

/*
Below is example code for constructing a json object and then serializing it.

 let loginCredentials: Dictionary = ["username": username, "passphrase": passphrase];
 print(loginCredentials);
 let jsonData = try! JSONSerialization.data(withJSONObject: loginCredentials, options: JSONSerialization.WritingOptions.prettyPrinted)
 print(String(decoding: jsonData, as: UTF8.self))
 
 let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
 print(jsonObject)
 */

import Foundation

class CTApiSession {
    
    var accessToken: String = ""
    
    func login(username: String, passphrase: String) {
        
    }
    
    func logout() {
        
    }
}
