//
//  Category.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

public enum Category: String, CaseIterable, Codable {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var image: String {
        switch self {
        case .business:
            "business"
        case .entertainment:
            "entertainment"
        case .general:
            "general"
        case .health:
            "health"
        case .science:
            "science"
        case .sports:
            "sports"
        case .technology:
            "technology"
        }
    }
}
