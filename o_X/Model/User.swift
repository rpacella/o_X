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
    
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
}