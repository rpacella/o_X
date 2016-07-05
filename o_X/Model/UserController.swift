//
//  UserController.swift
//  o_X
//
//  Created by Riley Pacella on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class UserController: WebService {
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
        self.currentUser = User(email: email, password: password, token: "", client: "")
        self.userArray.append(self.currentUser!)
        onCompletion(self.currentUser!, nil)
        defaults.setObject(email, forKey: "currentUserEmail")
        defaults.setObject(password, forKey: "currentUserPassword")
        defaults.synchronize()
        
        
//        let user = ["email":email,"password":password]
//        
//        //remember a request has 4 things:
//        //1: A endpoint
//        //2: A method
//        //3: input data (optional)
//        //4: A response
//        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
//        
//        //execute request is a function we are able to call in UserController, because UserController extends WebService (See top of file, where UserController is defined)
//        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
//            
//            //Here is our completion closure for the web request. when the web service is done, this is what is executed.
//            //Not only is the code in this block executed, but we are given 2 input parameters, responseCode and json.
//            //responseCode is the response code from the server.
//            //json is the response data received
//            
//            print(json)
//            var user:User = User(email: "", password: "", token: "", client:"")
//            
//            if (responseCode == 200)   { //if the responseCode is 2xx (any responseCode in the 200's range is a success case. For example, some servers return 201 for successful object creation)
//                
//                //successfully registered user. get the obtained data from the json response data and create the user object to give back to the calling ViewController
//                let t = json["data"]["email"].stringValue
//                user = User(email: json["data"]["email"].stringValue,password:"not_given_and_not_stored",token:json["data"]["token"].stringValue, client:json["data"]["client"].stringValue)
//                //while we at it, lets persist our user
//        //self.currentUser
//                
//                //and while we still at it, lets set the user as logged in. This is good programming as we are keeping all the user management inside the UserController and handling it at the right time
//        //self.curre
//                
//                //Note that our registerUser function has 4 parameters: email, password, presentingViewController and requestCompletionFunction
//                //requestCompletionFunction is a closure for what is to happen in the ViewController when we are done with the webservice.
//                
//                //lets execute that closure now - Lets me be clear. This is 1 step more advanced than normal. We are executing a closure inside a closure (we are executing the viewControllerCompletionFunction from within the requestCompletionFunction.
//                onCompletion(user,nil)
//            }   else    {
//                //the web service to create a user failed. Lets extract the error message to be displayed
//                
//                let errorMessage = json["errors"]["full_messages"][0].stringValue
//                
//                //execute the closure in the ViewController
//                onCompletion(nil,errorMessage)
//            }
//            
//        })
        
//        let user = ["email": email, "password": password]
//        let request = self.createMutableAnonRequest(NSURL(string: "https://ox-backend.herokuapp.com/auth"), method: "POST", parameters: user)
//        
//        self.executeRequest(request, requestCompletionFunction: (Int, JSON) -> ())
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