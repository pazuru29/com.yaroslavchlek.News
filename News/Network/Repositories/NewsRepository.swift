//
//  NewsRepository.swift
//  News
//
//  Created by Yaroslav Chlek on 26.12.2023.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getUserNews(country: Country, category: Category) async throws -> NewsResponse
    
    func getCountryNews(country: Country) async throws -> NewsResponse
    
    func getSearchNews(searchText: String) async throws -> NewsResponse
}

class NewsRepository: NewsRepositoryProtocol {
    func getUserNews(country: Country, category: Category) async throws -> NewsResponse {
        print("Country: \(country)")
        print("listOfCategory: \(category)")
        
        let response = try await APIRequestDispatcher.request(apiRouter: .userNews(country: country.codeA2, listOfCategories: category.rawValue.lowercased()), responseClass: NewsResponse.self)
        
        return response
    }
    
    func getCountryNews(country: Country) async throws -> NewsResponse {
        let response = try await APIRequestDispatcher.request(apiRouter: .countryNews(country: country.codeA2), responseClass: NewsResponse.self)
        
        return response
    }
    
    func getSearchNews(searchText: String) async throws -> NewsResponse {
        let response = try await APIRequestDispatcher.request(apiRouter: .search(searchText: searchText), responseClass: NewsResponse.self)
        
        return response
    }
}
