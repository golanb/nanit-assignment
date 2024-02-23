//
//  AvatarPickerView.swift
//  NanitHomeAssignment
//
//  Created by Golan Bar-Nov on 22/02/2024.
//

import PhotosUI
import SwiftUI

struct AvatarPickerView: View {
    @Bindable var baby: Baby
    var hideCameraIcon: Bool = false
    @Environment(\.theme) private var theme
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
            PhotosPicker(selection: $selectedPhoto, matching: .any(of: [.images, .not(.screenshots)])) {
                GeometryReader { geometry in
                    let radius = geometry.size.width / 2
                    Circle()
                        .stroke(theme.color.border, lineWidth: 12)
                        .fill(theme.color.surface)
                        .frame(maxWidth: .infinity)
                        .overlay(babyImage(radius: radius))
                        .overlay {
                            CameraIconView(radius: radius)
                                .opacity(hideCameraIcon ? 0 : 1)
                        }
                }
            }
            .onChange(of: selectedPhoto, loadPhoto)
    }
    
    @ViewBuilder
    private func babyImage(radius: CGFloat) -> some View {
        if let data = baby.photo, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle(), style: FillStyle())
        } else {
            Image("profile-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: radius)
                .foregroundStyle(theme.color.border)
        }
    }
    
    private func loadPhoto() {
        Task { @MainActor in
            baby.photo = try await selectedPhoto?.loadTransferable(type: Data.self)
        }
    }
}

struct CameraIconView: View {
    let radius: CGFloat
    @Environment(\.theme) private var theme
    
    private var offset: CGFloat {
        sqrt(radius * radius / 2)
    }
    
    var body: some View {
        Circle()
            .fill(theme.color.border)
            .frame(width: 36)
            .overlay {
                Image("camera-plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23)
                    .padding([.top, .leading], 4)
            }
            .offset(x: offset, y: -offset)
            .foregroundStyle(.white)
    }
}

#Preview {
    AvatarPickerView(baby: Previewer.shared.baby, hideCameraIcon: false)
        .modelContainer(Previewer.shared.container)
}
