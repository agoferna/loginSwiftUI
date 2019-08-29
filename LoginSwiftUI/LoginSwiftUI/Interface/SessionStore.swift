//
//  LoginInterfaceViewController.swift
//  LoginSwiftUI
//
//  Created by Adrià González Fernández on 29/08/2019.
//  Copyright © 2019 Adrià González Fernández. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionStore: BindableObject {

        var didChange = PassthroughSubject<SessionStore, Never>()
        var session: User? { didSet { self.didChange.send(self) }}
        var handle: AuthStateDidChangeListenerHandle?
        
        func listen () {
            // monitor authentication changes using firebase
            handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                    // if we have a user, create a new user model
                    print("Got user: \(user)")
                    self.session = User(
                        uid: user.uid,
                        displayName: user.displayName,
                        email: user.email
                    )
                } else {
                    // if we don't have a user, set our session to nil
                    self.session = nil
                }
            }
        }
        
    func signUp( email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn( email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
