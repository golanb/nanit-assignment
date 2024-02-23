//
//  Theme.swift
//  Yoga
//
//  Created by Golan Bar-Nov on 19/02/2024.
//

import SwiftUI

// MARK: - Fonts

// Semantic font (responds to dynamic type) with custom font family
struct ThemeFont {
    private static let fontName = "BentonSans Regular.otf"
    
    var largeTitle: Font = .custom(fontName, size: 34, relativeTo: .largeTitle)
    var title: Font = .custom(fontName, size: 28, relativeTo: .title)
    var title2: Font = .custom(fontName, size: 23, relativeTo: .title2)
    var title3: Font = .custom(fontName, size: 21, relativeTo: .title3)
    var headline: Font = .custom(fontName, size: 20, relativeTo: .headline)
    var body: Font = .custom(fontName, size: 17, relativeTo: .body)
    var callout: Font = .custom(fontName, size: 16, relativeTo: .callout)
    var footnote: Font = .custom(fontName, size: 13, relativeTo: .footnote)
    var caption: Font = .custom(fontName, size: 12, relativeTo: .caption)
    var caption2: Font = .custom(fontName, size: 11, relativeTo: .caption2)
}

// MARK: - Colors

struct ThemeColor {
    let border: Color
    let background: Color
    let surface: Color
    let text: Color
    
    init(themeName: String) {
        self.border = Color("\(themeName)/borderColor")
        self.background = Color("\(themeName)/backgroundColor")
        self.surface = Color("\(themeName)/surfaceColor")
        self.text = Color("textColor")
    }
}

// MARK: - Theme

enum Theme: String, CaseIterable {
    case elephant, fox, pelican
}

extension Theme {
    var font: ThemeFont { ThemeFont() }
    var color: ThemeColor { ThemeColor(themeName: rawValue) }
    var backgroundImage: Image { Image("\(rawValue)/backgroundImage") }
}

extension Theme {
    static func random() -> Theme {
        allCases.randomElement()! // collection is not empty. Force unwrap is safe here
    }
}

// MARK: - Theme Environment Variable

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: Theme = .elephant
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func theme(_ value: Theme) -> some View {
        environment(\.theme, value)
    }
}
