//
//  CategoryView.swift
//  News
//
//  Created by Yaroslav Chlek on 28.12.2023.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) private var scheme
    @AppConfiguration(\.categories) var categories
    
    @State var listOfSelectedCategory: [Category] = []
    
    var body: some View {
        VStack {
            Text("Select categories")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            ZStack {
                ScrollView {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCard(scheme: scheme, category: category, isSelected: listOfSelectedCategory.contains(category), onPressed: {
                            if let index = listOfSelectedCategory.firstIndex(of: category) {
                                listOfSelectedCategory.remove(at: index)
                            } else {
                                listOfSelectedCategory.append(category)
                            }
                        })
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                    .padding(.bottom, 72)
                    .padding(.top, 16)
                }
                VStack {
                    Spacer()
                    Button("Save") {
                        categories = listOfSelectedCategory
                        presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, 16)
                    .disabled(listOfSelectedCategory.isEmpty)
                }
            }
            .onAppear {
                listOfSelectedCategory = categories
            }
        }
    }
}

#Preview {
    CategoryView()
}
