//
//  CategoryCard.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct CategoryCard: View {
    var scheme: ColorScheme
    var category: Category
    var isSelected: Bool
    var onPressed: () -> Void
    
    var body: some View {
        HStack() {
            Text(category.rawValue)
                .foregroundStyle(isSelected ? .white : .appText)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.leading, 16)
            Spacer()
            ZStack {
                Image(category.image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .blur(radius: 10)
                    .opacity(0.8)
                Image(category.image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
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
//        CategoryCard(category: .business, isSelected: true, onPressed: {
//            
//        })
//            .padding(.horizontal, 16)
//        CategoryCard(category: .health, isSelected: false, onPressed: {
//            
//        })
//            .padding(.horizontal, 16)
//    }
//}
