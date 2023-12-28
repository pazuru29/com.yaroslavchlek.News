//
//  Country.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

public enum Country: String, CaseIterable, Codable {
    case it = "Italy"
    case ro = "Romania"
    case rs = "Serbia"
    case ru = "Russia"
    case tr = "Turkey"
    case ua = "Ukraine"
    case us = "USA"
    
    var flag: String {
        switch self {
        case .it:
            "🇮🇹"
        case .ro:
            "🇷🇴"
        case .rs:
            "🇷🇸"
        case .ru:
            "🇷🇺"
        case .tr:
            "🇹🇷"
        case .ua:
            "🇺🇦"
        case .us:
            "🇺🇸"
        }
    }
    
    var codeA2: String {
        switch self {
        case .it:
            "it"
        case .ro:
            "ro"
        case .rs:
            "rs"
        case .ru:
            "ru"
        case .tr:
            "tr"
        case .ua:
            "ua"
        case .us:
            "us"
        }
    }
}
