//
//  MainView.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct MainView: View, KeyboardReadable {
    @AppStorage("userTheme") private var userTheme: Theme  = .systemDefault
    
    @StateObject var userNewsViewModel: UserNewsViewModel = UserNewsViewModel()
    @StateObject var countryNewsViewModel: CountryNewsViewModel = CountryNewsViewModel()
    @StateObject var searchViewModel: SearchViewModel = SearchViewModel()
    
    //TODO: - change to user
    @State private var activeTab: Tab = .userNews
    
    @State private var isKeyboardVisible = false
    
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                // MARK: User News
                NavigationStack {
                    UserNewsView()
                }
                .environmentObject(userNewsViewModel)
                .setUpTab(.userNews)
                
                // MARK: Country News
                NavigationStack {
                    CountryNewsView()
                }
                .environmentObject(countryNewsViewModel)
                .setUpTab(.countryNews)
                
                // MARK: Search News
                NavigationStack {
                    SearchView()
                }
                .environmentObject(searchViewModel)
                .setUpTab(.search)
                
                // MARK: Settings News
                NavigationStack {
                    SettingsView()
                }
                .environmentObject(userNewsViewModel)
                .environmentObject(countryNewsViewModel)
                .environmentObject(searchViewModel)
                .setUpTab(.settings)
            }
            if(!isKeyboardVisible) {
                CustomTabBar()
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
        .onReceive(keyboardPublisher, perform: { newIsKeyboardVisible in
            print("Is keyboard visible? ", newIsKeyboardVisible)
            isKeyboardVisible = newIsKeyboardVisible
        })
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: activeTab == tab ? tab.activeIcon : tab.rawValue)
                        .font(.title2)
                        .contentTransition(.symbolEffect(.replace.downUp.byLayer))
                    
                    Text(tab.title)
                        .font(.caption)
                        .textScale(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.appPrimaryTapped : Color.appPrimary.opacity(0.5))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    activeTab = tab
                }
            }
        }
        .frame(height: 72)
        .background(.bar)
    }
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}

//#Preview {
//    HomeView()
//}
