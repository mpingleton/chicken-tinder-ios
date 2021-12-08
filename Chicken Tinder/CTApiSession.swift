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
    
    func login(username: String, passphrase: String, completionHandler: @escaping (_ error: Int?) -> Void) {
        
        // Send an http request and get the access token back.
        let authCredentials = try! JSONSerialization.data(withJSONObject: ["username": username, "passphrase": passphrase], options: JSONSerialization.WritingOptions.prettyPrinted)
        let loginUrl = URL(string: "http://localhost:3001/api/auth/login")!
        var loginRequest = URLRequest(url: loginUrl)
        loginRequest.httpMethod = "POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        loginRequest.httpBody = authCredentials
        
        let loginTask = URLSession.shared.dataTask(with: loginRequest) { data, response, error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                // Successful log in.
                let resJson = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.topLevelDictionaryAssumed) as! NSDictionary
                self.accessToken = resJson["accessToken"] as! String
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            else if statusCode == 403 {
                // Incorrect username or passphrase.
                self.accessToken = ""
                DispatchQueue.main.async {
                    completionHandler(403)
                }
            }
        }
        loginTask.resume()
    }
    
    func logout() {
        
        // Make sure we have an access token first.
        if accessToken.isEmpty {
            return
        }
        
        // Send a logout request.
        let logoutUrl = URL(string: "http://localhost:3001/api/auth/logout")!
        var logoutRequest = URLRequest(url: logoutUrl)
        logoutRequest.httpMethod = "POST"
        logoutRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        logoutRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let logoutTask = URLSession.shared.dataTask(with: logoutRequest) { data, response, error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                // Successful log out.
                // COME BACK: Clear all of the other state data.
                self.accessToken = ""
            }
        }
        logoutTask.resume()
    }
}
