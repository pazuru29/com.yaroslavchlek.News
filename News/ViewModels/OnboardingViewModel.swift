//
//  SettingsModelView.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var selectedCountry: Country?
    
    @Published var listOfSelectedCategory: [Category] = []
    
    func changeSelectedCountry(country: Country) {
        if selectedCountry == country {
            selectedCountry = nil
        } else {
            selectedCountry = country
        }
    }
    
    func changeListOfCategory(category: Category) {
        if let index = listOfSelectedCategory.firstIndex(of: category) {
            listOfSelectedCategory.remove(at: index)
        } else {
            listOfSelectedCategory.append(category)
        }
    }
}
