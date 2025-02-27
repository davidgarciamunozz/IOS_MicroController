//
//  PMApp_MicroControllerApp.swift
//  PMApp_MicroController
//
//  Created by David García on 26/02/25.
//

import SwiftUI
import SwiftData

@main
struct PMApp_MicroControllerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MotionView()
        }
        .modelContainer(sharedModelContainer)
    }
}
