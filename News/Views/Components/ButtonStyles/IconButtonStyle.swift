//
//  IconButtonStyle.swift
//  News
//
//  Created by Yaroslav Chlek on 28.12.2023.
//

import SwiftUI

struct IconButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .frame(width: 48, height: 48)
            .background(.clear)
            .foregroundStyle(getForeground(isPressed: configuration.isPressed))
            .animation(.easeIn, value: isEnabled)
    }
    
    func getForeground(isPressed: Bool) -> Color {
        guard isEnabled else {
            return .appGray
        }
        return isPressed ? .appPrimary : .appPrimaryTapped
    }
}

#Preview {
    Button(action: {
        
    }, label: {
        Image(systemName: "rectangle.and.pencil.and.ellipsis")
    })
    .buttonStyle(IconButtonStyle())
}
