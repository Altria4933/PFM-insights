//
//  ContentView.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI

import SwiftUI
import CoreData

struct ContentView: View {
    init() {
    
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        TabView{
            Home().tabItem { Image(systemName: "house")
                Text("Home")
            }
            Habit().tabItem { Image(systemName: "heart")
                Text("Habit")
                    
            }
            Home().tabItem { Image(systemName: "target")
                Text("Goal")
            }
            Login()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .tabItem { Image(systemName: "person")
                Text("Account")
            }
        }.accentColor(Color("MainColor"))
        
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
}
}

