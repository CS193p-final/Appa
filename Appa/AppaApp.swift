//
//  AppaApp.swift
//  Appa
//
//  Created by Duong Pham on 2/2/21.
//

import SwiftUI

@main
struct AppaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
