//
//  UserNewsViewModel.swift
//  News
//
//  Created by Yaroslav Chlek on 26.12.2023.
//

import SwiftUI

class UserNewsViewModel: ObservableObject {
    @AppConfiguration(\.categories) var categories
    @AppConfiguration(\.country) var country
    
    private let newsRepository: NewsRepository = NewsRepository()
    
    @MainActor @Published var mapOfNews: [Category:[News]] = [:]
    
    //    @Published var currentCategory: Category = AppConfiguration.categories.wrappedValue.isEmpty ? Category.sports : Category(rawValue: (AppConfiguration.categories.wrappedValue.first)!.rawValue) ?? Category.sports
    
    func getInitData(indexOfCategory: Int) {
        Task {
            do {
                let currentCategory = categories.isEmpty ? .business : categories[indexOfCategory]
                let list = try await newsRepository.getUserNews(country: country, category: currentCategory)
                mapOfNews[currentCategory] = list.articles.filter({ news in
                    news.title != "[Removed]"
                })
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
    }
    
    func clearList() {
        mapOfNews = [:]
    }
}
