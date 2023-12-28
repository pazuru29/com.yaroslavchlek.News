//
//  AppSettingsButton.swift
//  News
//
//  Created by Yaroslav Chlek on 28.12.2023.
//

import SwiftUI

struct AppSettingsButton: View {
    let assetName: String
    let title: String
    let subtitle: String
    let assetColor: Color
    let bgColor: Color
    let onPressed: () -> Void
    
    var body: some View {
        Button(action: onPressed, label: {
            bodyButton()
        })
    }
    
    func bodyButton() -> some View {
        return HStack {
            HStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(bgColor)
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                    Image(systemName: assetName)
                        .foregroundStyle(assetColor)
                }
                    .padding(.trailing, 16)
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundStyle(.appText)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .foregroundStyle(.appText)
                        .padding(.top, 4)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.appGray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AppSettingsButton(assetName: "sun.min", title: "Display preference", subtitle: "Adjust your display", assetColor: .appAccientSecondaryColor1, bgColor: .appAccientColor1) {
        
    }
}
