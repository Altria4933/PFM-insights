//
//  PFM_insightsApp.swift
//  PFM insights
//
//  Created by Altria on 11/10/20.
//

import SwiftUI

@main
struct PFM_insightsApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
