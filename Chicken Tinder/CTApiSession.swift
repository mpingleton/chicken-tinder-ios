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
    var restaurantStack: [CTRestaurant] = []
    
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
            else {
                self.accessToken = ""
                DispatchQueue.main.async {
                    completionHandler(statusCode)
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
    
    func getAllRestaurants(completionHandler: @escaping (_ error: Int?) -> Void) {
        
        // Make sure we have an access token first.
        if accessToken.isEmpty {
            return
        }
        
        // Clear the current stack.
        restaurantStack.removeAll()
        
        // Send a request.
        let getAllRestaurantsUrl = URL(string: "http://localhost:3001/api/restaurant")!
        var getAllRestaurantsRequest = URLRequest(url: getAllRestaurantsUrl)
        getAllRestaurantsRequest.httpMethod = "GET"
        getAllRestaurantsRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getAllRestaurantsRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let getAllRestaurantsTask = URLSession.shared.dataTask(with: getAllRestaurantsRequest) { data, response, error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let responseData = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                for restaurantObject in (responseData as! [NSDictionary]) {
                    let tmpRestaurant = CTRestaurant(
                        withId: restaurantObject["id"] as! Int,
                        withName: restaurantObject["name"] as! String,
                        withLocation: restaurantObject["location"] as! String
                    )
                    
                    let photoUrls = restaurantObject["photos"] as! [NSDictionary]
                    for photoUrl in photoUrls {
                        tmpRestaurant.images.append(CTRestaurantImage(withUrl: photoUrl["url"] as! String))
                    }
                    
                    self.restaurantStack.append(tmpRestaurant)
                }
                
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(statusCode)
                }
            }
        }
        getAllRestaurantsTask.resume()
    }
    
    func createSession(location: String, completionHandler: @escaping (_ joinCode: String?, _ error: Int?) -> Void) {
        
        // Make sure we have an access token first.
        if accessToken.isEmpty {
            return
        }
        
        // Send a create session request.
        let createSessionUrl = URL(string: "http://localhost:3001/api/session")!
        var createSessionRequest = URLRequest(url: createSessionUrl)
        createSessionRequest.httpMethod = "PUT"
        createSessionRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        createSessionRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        createSessionRequest.httpBody = try! JSONSerialization.data(withJSONObject: ["location": location], options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let createSessionTask = URLSession.shared.dataTask(with: createSessionRequest) { data, response, error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 201 {
                // Successfully created a session.
                let responseData = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                DispatchQueue.main.async {
                    completionHandler(((responseData as! NSDictionary)["joinCode"] as! String), nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(nil, statusCode)
                }
            }
        }
        createSessionTask.resume()
    }
    
    func joinSession(joinCode: String, completionHandler: @escaping (_ error: Int?) -> Void) {
        
        // Make sure we have an access token first.
        if accessToken.isEmpty {
            return
        }
        
        // Send a join session request.
        let joinSessionUrl = URL(string: "http://localhost:3001/api/session/join")!
        var joinSessionRequest = URLRequest(url: joinSessionUrl)
        joinSessionRequest.httpMethod = "POST"
        joinSessionRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        joinSessionRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        joinSessionRequest.httpBody = try! JSONSerialization.data(withJSONObject: ["joinCode": joinCode], options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let joinSessionTask = URLSession.shared.dataTask(with: joinSessionRequest) { data, response, error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                // Successfully created a session.
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(statusCode)
                }
            }
        }
        joinSessionTask.resume()
    }
    
    func enterLike(restaurantId: Int, completionHandler: @escaping (_ error: Int?) -> Void) {
        
        // Make sure we have an access token first.
        if accessToken.isEmpty {
            return
        }
        
        // Send a request to submit the like.
        let enterLikeUrl = URL(string: "http://localhost:3001/api/like")!
        var enterLikeRequest = URLRequest(url: enterLikeUrl)
        enterLikeRequest.httpMethod = "PUT"
        enterLikeRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        enterLikeRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        enterLikeRequest.httpBody = try! JSONSerialization.data(withJSONObject: ["restaurantId": restaurantId], options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let enterLikeTask = URLSession.shared.dataTask(with: enterLikeRequest) { data, response, error in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                // Successfully created a session.
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    completionHandler(statusCode)
                }
            }
        }
        enterLikeTask.resume()
    }
}
