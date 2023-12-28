//
//  CountryNewsViewModel.swift
//  News
//
//  Created by Yaroslav Chlek on 27.12.2023.
//

import Foundation

class CountryNewsViewModel: ObservableObject {
    @AppConfiguration(\.country) var country
    
    private let newsRepository: NewsRepository = NewsRepository()
    
    @MainActor @Published var listOfNews: [News] = []
    
    func getInitData() {
        Task {
            do {
                let list = try await newsRepository.getCountryNews(country: country)
                await MainActor.run {
                    listOfNews = list.articles.filter({ news in
                        news.title != "[Removed]"
                    })
                }
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
    }
}
