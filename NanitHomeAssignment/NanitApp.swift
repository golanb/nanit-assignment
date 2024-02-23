//
//  NanitApp.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 15/02/2024.
//

import SwiftUI
import SwiftData

@main
struct NanitApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Baby.self)
    }
}
