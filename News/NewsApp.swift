//
//  NewsApp.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

@main
struct NewsApp: App {
    @AppConfiguration(\.isFirstTime) var isFirstTime
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            if isFirstTime {
                NavigationStack{
                    OnboardingCountryView()
                }
                .environmentObject(onboardingViewModel)
            } else {
                MainView()
            }
        }
    }
}
