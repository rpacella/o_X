//
//  User.swift
//  o_X
//
//  Created by Riley Pacella on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

//User Model

class User: NSObject {
    
    var email : String
    var password : String
    var token : String
    var client : String
    
    
    init(email: String, password: String, token: String, client: String){
        self.email = email
        self.password = password
        self.token = token
        self.client = client
    }
}