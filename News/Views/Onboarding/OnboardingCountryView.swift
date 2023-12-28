//
//  OnboardingCountryView.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct OnboardingCountryView: View {
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(Country.allCases, id: \.self) { country in
                    CountryCard(scheme: scheme, country: country, isSelected: onboardingViewModel.selectedCountry == country, onPressed: {
                        onboardingViewModel.changeSelectedCountry(country: country)
                    })
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .padding(.bottom, 72)
                .padding(.top, 16)
            }
            VStack {
                Spacer()
                NavigationLink("Next", destination: OnboardingCategoryView())
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, 16)
                    .disabled(onboardingViewModel.selectedCountry == nil)
            }
        }
        .navigationTitle("Select country")
    }
}

//#Preview {
//    NavigationStack {
//        OnboardingCountryView()
//    }
//    .environmentObject(SettingsViewModel())
//}
