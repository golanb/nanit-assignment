//
//  AgeView.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 22/02/2024.
//

import SwiftUI

struct AgeView: View {
    let age: Age
    
    var body: some View {
        HStack(spacing: 4) {
            Image("swirls-leading")
            Spacer()
                .frame(width: 18)
            ForEach(age.digits, id: \.self) { digit in
                Image(digit)
            }
            Spacer()
                .frame(width: 18)
            Image("swirls-trailing")
        }
    }
}

#Preview {
    AgeView(age: Date(timeIntervalSinceNow: -31622400).age)
}
