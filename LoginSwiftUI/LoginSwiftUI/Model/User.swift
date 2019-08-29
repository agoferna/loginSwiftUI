//
//  User.swift
//  LoginSwiftUI
//
//  Created by Adrià González Fernández on 29/08/2019.
//  Copyright © 2019 Adrià González Fernández. All rights reserved.
//

import UIKit

class User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
