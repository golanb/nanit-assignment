//
//  BabyAgeView.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 22/02/2024.
//

import SwiftUI

struct BabyAgeView: View {
    let baby: Baby
    @Environment(\.theme) private var theme
    
    private var age: Age {
        baby.birthday?.age ?? .months(0)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("today \(baby.name) is")
                .lineLimit(nil)
            Spacer()
                .frame(height: 13)
            AgeView(age: age)
            Spacer()
                .frame(height: 14)
            Text("\(age.pluralUnit) old!")
        }
        .textCase(.uppercase)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    NavigationView {
        BabyAgeView(baby: Previewer.shared.baby)
            .padding(.horizontal, 80)
    }
    .theme(.fox)
    .modelContainer(Previewer.shared.container)
}
