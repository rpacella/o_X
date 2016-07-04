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
    
    var userArray : Array<User> = []
    
//    let onCompletion = { (currentUser : User?, error: String?) in
//    
//        let if errorMessage = error as? String {
//            let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
//            
//            let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
//                
//            })
//            
//            alert.addAction(dismissAlertAction)
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
//
//        }
//    
//    }

    func register (email: String, password: String, onCompletion: (User?, String?) -> Void) {
        
        if email == "" {
            onCompletion(nil, "Please enter an email")
        }
        if password.characters.count < 6 {
            onCompletion(nil, "Error because password is too short")
            return
        } else {
            for User in userArray {
                if User == currentUser {
                    onCompletion(nil, "User is already registered")
                    return
                }
            }
        }
        self.currentUser = User(email: email, password: password)
        self.userArray.append(self.currentUser!)
        onCompletion(self.currentUser, nil)
    }

    func login (email: String, password: String, onCompletion: (User?, String?) -> Void) {
        self.currentUser = User(email: email, password: password)

        for User in userArray {
            if User.email == currentUser!.email && User.password == currentUser!.password {
                onCompletion(currentUser, nil)
            }
            else {
                onCompletion(nil, "Your email or password is incorrect")
            }
        }
        
    }
    
    func logout (onCompletion: (String?) -> Void) {
        self.currentUser!.password = ""
        self.currentUser!.email = ""
    }
    
}