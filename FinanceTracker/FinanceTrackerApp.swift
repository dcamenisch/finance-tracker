//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import SwiftUI

@main
struct FinanceTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AccountStore())
        }
    }
}
