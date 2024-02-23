//
//  AnniversaryView.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 15/02/2024.
//

import SwiftUI

struct AnniversaryView: View {
    @Bindable var baby: Baby
    @State private var theme: Theme = .random() // set a random theme
    @State private var snapshotImage = Image(uiImage: UIImage())
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var displayScale
    
    var body: some View {
        makeContentView()
            .onAppear {
                renderSnapshot()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("", systemImage: "arrow.backward") {
                        dismiss()
                    }
                    .tint(.black)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(
                        item: snapshotImage,
                        preview: SharePreview("Share the news",image: snapshotImage)
                    )
                    .tint(.black)
                }
            }
    }
    
    @ViewBuilder
    private func makeContentView(isSnapshot: Bool = false) -> some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(minHeight: 20, maxHeight: 60)
                BabyAgeView(baby: baby)
                    .padding(.horizontal, 50)
                Spacer()
                    .frame(height: 20)
                
                AvatarPickerView(baby: baby, hideCameraIcon: isSnapshot)
                    .frame(width: 221)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            theme.backgroundImage
                .resizable()
                .scaledToFit()
                .allowsHitTesting(false)
            
            Image("nanit-logo")
                .padding(.bottom, 170)
        }
        .theme(theme)
        .font(theme.font.title3)
        .foregroundStyle(theme.color.text)
        .background(theme.color.background)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
        .navigationBarBackButtonHidden(true)
    }
    
    @MainActor
    private func renderSnapshot() {
        let content = makeContentView(isSnapshot: true).snapshotSize()
        let renderer = ImageRenderer(content: content)
        renderer.scale = displayScale
        if let uiImage = renderer.uiImage {
            snapshotImage = Image(uiImage: uiImage)
        }
    }
}

fileprivate extension View {
    func snapshotSize() -> some View {
        let size = UIScreen.main.bounds.size
        return self.frame(width: size.width, height: size.height - 150)
    }
}

#Preview {
    NavigationView {
        AnniversaryView(baby: Previewer.shared.baby)
    }
    .modelContainer(Previewer.shared.container)
}
