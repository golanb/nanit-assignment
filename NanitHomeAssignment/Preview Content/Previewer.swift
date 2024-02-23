//
//  Previewer.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 16/02/2024.
//

import SwiftUI
import SwiftData
import UIKit

@MainActor
struct Previewer {
    let container: ModelContainer
    let baby: Baby
    
    static var shared = Previewer()
    
    private init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try! ModelContainer(for: Baby.self, configurations: config)
        let birthdate = Calendar.current.date(byAdding: .year, value: -3, to: .now)
        let photo = UIImage(named: "baby-boss")?.pngData()
        baby = Baby(name: "Theodore Templeton Jr.", birthDate: birthdate, photo: photo)
        container.mainContext.insert(baby)
    }
    
}
