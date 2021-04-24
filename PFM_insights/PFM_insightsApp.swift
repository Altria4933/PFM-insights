//
//  PFM_insightsApp.swift
//  PFM_insights
//
//  Created by Shane Xu on 24/04/21.
//

import SwiftUI

@main
struct PFM_insightsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
