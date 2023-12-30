//
//  TabEnum.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case userNews = "newspaper"
    case countryNews = "mappin"
    case search = "magnifyingglass"
    case settings = "gear.circle"
    
    var activeIcon: String {
        switch self {
        case .userNews:
            "newspaper.fill"
        case .countryNews:
            "mappin.and.ellipse"
        case .search:
            "text.magnifyingglass"
        case .settings:
            "gear.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .userNews:
            "News for you"
        case .countryNews:
            "Country news"
        case .search:
            "Search"
        case .settings:
            "Settings"
        }
    }
}
