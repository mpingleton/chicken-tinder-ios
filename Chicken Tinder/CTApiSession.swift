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
        
        // Send an http request and get the access token back.
        let authCredentials = try! JSONSerialization.data(withJSONObject: ["username": username, "passphrase": passphrase], options: JSONSerialization.WritingOptions.prettyPrinted)
        let loginUrl = URL(string: "http://localhost:3001/api/auth/login")!
        var loginRequest = URLRequest(url: loginUrl)
        loginRequest.httpMethod = "POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        loginRequest.httpBody = authCredentials
        
        let loginTask = URLSession.shared.dataTask(with: loginRequest) { data, response, error in
            if error != nil {
                print("Error: \(error)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                // Successful log in.
                let resJson = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.topLevelDictionaryAssumed) as! NSDictionary
                print(resJson["accessToken"]!)
            }
            else if statusCode == 403 {
                // Incorrect username or passphrase.
                
            }
        }
        loginTask.resume()
    }
    
    func logout() {
        
    }
}
