//
//  SearchViewModel.swift
//  News
//
//  Created by Yaroslav Chlek on 27.12.2023.
//

import Foundation

class SearchViewModel: ObservableObject {
    private let newsRepository: NewsRepository = NewsRepository()
    
    @MainActor @Published var listOfNews: [News] = []
    
    func getInitData(searchText: String) {
        Task {
            do {
                let list = try await newsRepository.getSearchNews(searchText: searchText.lowercased())
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
    
    func clearList() {
        Task {
            await MainActor.run {
                listOfNews = []
            }
        }
    }
}
