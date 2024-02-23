//
//  ContentView.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 15/02/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @Query private var babies: [Baby]
    
    
    var body: some View {
        NavigationStack(path: $path) {
            if let baby = babies.first {
                EditBabyView(baby: baby, navigationPath: $path)
            }
        }
        .task {
            if babies.isEmpty {
                modelContext.insert(Baby())
            }
        }
    }
}
