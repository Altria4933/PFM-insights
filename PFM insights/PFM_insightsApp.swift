//
//  PFM_insightsApp.swift
//  PFM insights
//
//  Created by Altria on 11/10/20.
//

import SwiftUI

@main
struct PFM_insightsApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
        }
    }
}
