//
//  EditBabyView.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 15/02/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditBabyView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var baby: Baby
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            Section("Baby photo (optional)") {
                HStack {
                    Spacer()
                    AvatarPickerView(baby: baby)
                        .frame(width: 100, height: 100)
                    Spacer()
                }
            }
            Section("Baby name (required)") {
                TextField("Name", text: $baby.name)
                    .textContentType(.name)
                    .disableAutocorrection(true)
            }
            Section("Baby birthday (required)") {
                DatePicker("Birthday",
                           selection: $baby.birthday.unwrap(defaultValue: .now),
                           in: Date.birthdayPickerRange,
                           displayedComponents: .date)
                
            }
            HStack {
                Spacer()
                Button("Show birthday screen") {
                    navigationPath.append(baby) // push the anniversary view into navigation stack
                }
                .disabled(!isValidBabyInput())
                Spacer()
            }
        }
        .navigationTitle("nanit")
        .navigationDestination(for: Baby.self) { baby in
            AnniversaryView(baby: baby)
        }
    }
    
    private func isValidBabyInput() -> Bool {
        guard let birthday = baby.birthday else { return false }
        return !baby.name.isEmpty && Date.birthdayPickerRange.contains(birthday)
    }
}

// MARK: - Helpers

fileprivate extension Binding {
    func unwrap<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(
            get: {
                self.wrappedValue ?? defaultValue
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}

fileprivate extension Date {
    static var birthdayPickerMinimumDate: Date {
        Calendar.current.date(byAdding: .year, value: -4, to: .now)!
    }
    
    static var birthdayPickerRange: ClosedRange<Date> {
        Date.birthdayPickerMinimumDate...Date.now
    }
}

#Preview {
    NavigationView {
        EditBabyView(baby: Previewer.shared.baby, navigationPath: .constant(NavigationPath()))
    }
    .modelContainer(Previewer.shared.container)
}
