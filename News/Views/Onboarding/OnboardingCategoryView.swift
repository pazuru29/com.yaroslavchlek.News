//
//  OnboardingCategoryView.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct OnboardingCategoryView: View {
    @Environment(\.colorScheme) private var scheme
    @AppConfiguration(\.isFirstTime) var isFirstTime
    @AppConfiguration(\.country) var country
    @AppConfiguration(\.categories) var categories
    
    
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryCard(scheme: scheme, category: category, isSelected: onboardingViewModel.listOfSelectedCategory.contains(category), onPressed: {
                        onboardingViewModel.changeListOfCategory(category: category)
                    })
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .padding(.bottom, 72)
                .padding(.top, 16)
            }
            VStack {
                Spacer()
                Button("Next") {
                    country = onboardingViewModel.selectedCountry ?? .us
                    categories = onboardingViewModel.listOfSelectedCategory
                    isFirstTime = false
                }
                .buttonStyle(MainButtonStyle())
                .padding(.horizontal, 16)
                .disabled(onboardingViewModel.listOfSelectedCategory.isEmpty)
            }
        }
        .navigationTitle("Select categories")
        
    }
}


//#Preview {
//    NavigationStack {
//        OnboardingCategoryView()
//    }
//    .environmentObject(SettingsViewModel())
//}
