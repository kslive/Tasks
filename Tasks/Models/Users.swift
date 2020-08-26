//
//  Users.swift
//  Tasks
//
//  Created by Eugene Kiselev on 26.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import Foundation
import Firebase

struct Users {
    
    let uid: String
    let email: String
    
    init(user: User) {
        
        self.uid = user.uid
        self.email = user.email!
    }
}
