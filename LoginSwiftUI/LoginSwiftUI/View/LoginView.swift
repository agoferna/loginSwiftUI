//
//  ContentView.swift
//  LoginSwiftUI
//
//  Created by Adrià González Fernández on 29/08/2019.
//  Copyright © 2019 Adrià González Fernández. All rights reserved.
//

import SwiftUI

struct LoginView : View {
    
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            TextField($email, placeholder: Text("email address"))
            SecureField($password, placeholder: Text("Password"))
            if (error) {
                Text("ahhh crap")
            }
            Button(action: signIn) {
                Text("Sign in")
            }
        }
    }
}
