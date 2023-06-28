//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

@main
struct FinanceTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
