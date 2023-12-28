//
//  CountryCard.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct CountryCard: View {
    var scheme: ColorScheme
    var country: Country
    var isSelected: Bool
    var onPressed: () -> Void
    
    
    var body: some View {
        HStack() {
            Text(country.rawValue)
                .foregroundStyle(isSelected ? .white : .appText)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.leading, 16)
            Spacer()
            Text(country.flag)
                .font(.largeTitle)
            .padding(.vertical, 16)
            .padding(.trailing, 16)

        }
        .background(isSelected ? .appPrimaryTapped : .appBackgroundComponent)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            if !isSelected  {
                Color.gray.opacity(0.15)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .shadow(color: scheme == .dark ? .clear : isSelected ? .gray.opacity(0.3) : .clear, radius: 10, y: 5)
        .contentShape(.rect)
        .animation(.easeIn, value: isSelected)
        .onTapGesture {
            onPressed()
        }
    }
}

//#Preview {
//    Group {
//        CountryCard(country: .it, isSelected: true, onPressed: {
//            
//        })
//            .padding(.horizontal, 16)
//        CountryCard(country: .ro, isSelected: false, onPressed: {
//            
//        })
//            .padding(.horizontal, 16)
//    }
//}
