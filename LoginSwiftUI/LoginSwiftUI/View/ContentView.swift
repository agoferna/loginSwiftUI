//
//  ContentView.swift
//  LoginSwiftUI
//
//  Created by Adrià González Fernández on 29/08/2019.
//  Copyright © 2019 Adrià González Fernández. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                Text("Hello user!")
            } else {
                LoginView()
            }
            }.onAppear(perform: getUser)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
#endif
