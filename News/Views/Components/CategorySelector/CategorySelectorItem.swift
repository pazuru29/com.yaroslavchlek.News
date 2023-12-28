//
//  CategorySelectorItem.swift
//  News
//
//  Created by Yaroslav Chlek on 27.12.2023.
//

import SwiftUI

struct CategorySelectorItem: View {
    var title: String
    var isSelected: Bool
    
    var body: some View {
        Text(title)
            .foregroundStyle(isSelected ? .white : .appText)
            .font(.title3)
            .fontWeight(.regular)
            .padding(.horizontal,10)
            .padding(.vertical, 8)
            .background(isSelected ? .appPrimaryTapped : .appBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? .appPrimaryTapped : .appPrimary.opacity(0.3), lineWidth: 2))
            .clipShape(RoundedRectangle(cornerRadius: 100))
    }
}

#Preview {
    Group {
        CategorySelectorItem(title: "Sports", isSelected: true)
        CategorySelectorItem(title: "Sports", isSelected: false)
    }
}
