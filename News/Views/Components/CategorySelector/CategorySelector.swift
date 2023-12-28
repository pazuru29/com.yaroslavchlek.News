//
//  CategorySelector.swift
//  News
//
//  Created by Yaroslav Chlek on 27.12.2023.
//

import SwiftUI

struct CategorySelector: View {
    var items: [String]
    var onChangeIndex: (Int) -> Void
    var currentIndex: Int
    
    init(currentIndex: Int, items: [String], onChangeIndex: @escaping (Int) -> Void) {
        self.currentIndex = currentIndex
        self.onChangeIndex = onChangeIndex
        self.items = items
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(items.indices, id: \.self) { index in
                    return CategorySelectorItem(title: items[index], isSelected: currentIndex == index)
                        .contentShape(.rect)
                        .onTapGesture {
                            onChangeIndex(index)
                        }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 6)
        }
    }
}

#Preview {
    CategorySelector(currentIndex: 0, items: ["Sports", "Busines"]) { index in
        
    }
}
