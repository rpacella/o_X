//
//  UserController.swift
//  o_X
//
//  Created by Riley Pacella on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController {
    static var sharedInstance = UserController()
    var currentUser: User?
    var userArray : [User] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func register(email: String, password: String, onCompletion: (User?, String?) -> Void) {
        if email == "" {
            onCompletion(nil, "Please enter an email")
            return
        }
        else if password.characters.count < 6 {
            onCompletion(nil, "Password is too short")
            return
        }
        else {
            for user in userArray {
                if user.email == currentUser!.email {
                    onCompletion(nil, "User is already registered")
                    return
                }
            }
        }
        self.currentUser = User(email: email, password: password)
        self.userArray.append(self.currentUser!)
        onCompletion(self.currentUser!, nil)
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
    }

    func login (email: String, password: String, onCompletion: (User?, String?) -> Void) {
        for user in userArray {
            if user.email == email && user.password == password {
                currentUser = user
                onCompletion(currentUser, nil)
                defaults.setObject(email, forKey: "currentUserEmail")
                defaults.setObject(password, forKey: "currentUserPassword")
                defaults.synchronize()
                return
            }
        }
        
        onCompletion(nil, "Your email or password is incorrect")
    }
    
    func logout (onCompletion: (String?) -> Void) {
        defaults.removeObjectForKey("currentUserEmail")
       defaults.removeObjectForKey("currentUserPassword")
        self.currentUser = nil
        defaults.synchronize()
        onCompletion("onBoarding")
        
    }
    
}