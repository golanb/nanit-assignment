//
//  Age.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 23/02/2024.
//

import Foundation

enum Age {
    case months(Int)
    case years(Int)
}

extension Age {
    var value: Int {
        switch self {
        case .months(let value):
            return value
        case .years(let value):
            return value
        }
    }
    
    var pluralUnit: String {
        switch self {
        case .months(let value):
            return value == 1 ? "month" : "months"
        case .years(let value):
            return value == 1 ? "year" : "years"
        }
    }
    
    // Converts and age to its digits (each digit represents a matching image resource)
    // ie: age 34 --> ["3", "4"]
    var digits: [String] {
        Array(String(value)).map { String($0) }
    }
}

extension Date {
    var age: Age {
        let components = Calendar.current.dateComponents([.month, .year], from: self, to: .now)
        if let years = components.year, years > 0 {
            return .years(years)
        }
        return .months(components.month ?? 0)
    }
}
