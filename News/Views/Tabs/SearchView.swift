//
//  SearchNews.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI
import Combine

struct SearchView: View {
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject var searchViewModel: SearchViewModel
    @State var searchText: String = ""
    
    let searchPublisher = PassthroughSubject<String, Never>()
    
    var body: some View {
        ScrollViewReader { reader in
            VStack {
                ScrollView {
                    if searchViewModel.listOfNews.isEmpty {
                        Text("There's no news yet.\nSee what you can find.")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.top, 48)
                    } else {
                        ForEach(searchViewModel.listOfNews) { news in
                            return NavigationLink(destination: {
                                NewsDetailScreen(news: news)
                            }, label: {
                                NewsCard(scheme: scheme, news: news)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 16)
                            })
                        }
                    }
                }
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    searchViewModel.listOfNews = []
                } else {
                    searchPublisher.send(newValue)
                }
            })
            .onReceive(
                searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                    print(text)
                    if text.isEmpty {
                        searchViewModel.listOfNews = []
                    } else {
                        searchViewModel.getInitData(searchText: text)
                    }
                })
        }
        .navigationTitle("Search news")
        .searchable(text: $searchText)
    }
}
