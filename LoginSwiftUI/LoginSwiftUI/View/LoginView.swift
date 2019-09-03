//
//  ContentView.swift
//  LoginSwiftUI
//
//  Created by Adrià González Fernández on 29/08/2019.
//  Copyright © 2019 Adrià González Fernández. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct LoginView : View {
    
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var ref: DatabaseReference!

    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        loading = true
        error = false
        session.signOut()
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.read()
            }
        }
    }
    
    func register () {
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                
               
                
                let messagesDB = Database.database().reference().child(self.session.session?.uid ?? "").child("Messages")
                
                let messageDictionary : NSDictionary = ["Sender" : self.session.session!.email as String? ?? "", "MessageBody" : "OTRO USER"]
                messagesDB.childByAutoId().setValue(messageDictionary) {
                    (error, ref) in
                    if error != nil {
                        print(error!)
                    }
                    else {
                        print("Message saved successfully!")
                    }
                }
            }
        }
    }
    
        func read() {
            let messageDB = Database.database().reference().child(self.session.session?.uid ?? "").child("Messages")
            
            messageDB.observe(.childAdded, with: { snapshot in
                
                let snapshotValue = snapshot.value as! NSDictionary
                let text = snapshotValue["MessageBody"] as! String
                let sender = snapshotValue["Sender"] as! String
            })
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
            Button(action: register) {
                Text("Register")
            }
            }.onAppear {
                self.ref = Database.database().reference()
            }
    }
}
