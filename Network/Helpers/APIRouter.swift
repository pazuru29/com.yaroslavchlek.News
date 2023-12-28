//
//  NetworkHelper.swift
//  News
//
//  Created by Yaroslav Chlek on 26.12.2023.
//

import Foundation

enum APIRouter {
    static private let apiKey: String = "5ead1c9cb594425ba7bb10003e8a8720"
    
    case userNews(country: String, listOfCategories: String)
    case countryNews(country: String)
    case search(searchText: String)
    
    var host: String {
        switch self {
        case .userNews, .countryNews, .search:
            return "newsapi.org"
        }
    }
    
    var scheme: String {
        switch self {
        case .userNews, .countryNews, .search:
            return "https"
        }
    }
    
    var path: String {
        switch self {
        case .userNews:
            return "/v2/top-headlines"
        case .countryNews:
            return "/v2/top-headlines"
        case .search:
            return "/v2/everything"
        }
    }
    
    var method: String {
        switch self {
        case .userNews, .countryNews, .search:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        var queryList: [URLQueryItem] = []
        
        switch self {
        case .userNews(let country, let category):
            queryList.append(URLQueryItem(name: "country", value: country))
            queryList.append(URLQueryItem(name: "category", value: category))
            break
        case .countryNews(let country):
            queryList.append(URLQueryItem(name: "country", value: country))
            break
        case .search(let searchText):
            queryList.append(URLQueryItem(name: "q", value: searchText))
            break
        }
        queryList.append(URLQueryItem(name: "apiKey", value: "\(APIRouter.apiKey)"))
        
        return queryList
    }
}

