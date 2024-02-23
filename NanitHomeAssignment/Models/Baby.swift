//
//  Baby.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 15/02/2024.
//

import Foundation
import SwiftData

@Model
class Baby: Hashable, Identifiable {
    let id: UUID
    var name: String
    var birthday: Date?
    @Attribute(.externalStorage) var photo: Data?
    
    init(id: UUID = UUID(), name: String = "", birthDate: Date? = nil, photo: Data? = nil) {
        self.id = id
        self.name = name
        self.birthday = birthDate
        self.photo = photo
    }
}
