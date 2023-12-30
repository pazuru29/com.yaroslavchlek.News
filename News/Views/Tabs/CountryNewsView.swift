//
//  CountryNews.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct CountryNewsView: View {
    @Environment(\.colorScheme) private var scheme
    @AppConfiguration(\.country) var country
    
    @EnvironmentObject var countryNewsViewModel: CountryNewsViewModel
    
    @State var shouldScrollToTop: Bool = false
    let topItemId: String = "topItemId"
    
    var body: some View {
        ScrollViewReader { reader in
            VStack(spacing: 0) {
                ScrollView {
                    Color.clear
                        .id(topItemId)
                        .frame(height: 8)
                    if countryNewsViewModel.listOfNews == nil {
                        ProgressView()
                            .padding(.top, 72)
                    } else {
                        ForEach(countryNewsViewModel.listOfNews ?? []) { news in
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
                .onChange(of: shouldScrollToTop, {
                    withAnimation {  // add animation for scroll to top
                        reader.scrollTo(topItemId, anchor: .top) // scroll
                    }
                    shouldScrollToTop = false
                })
                .refreshable {
                    countryNewsViewModel.getInitData()
                }
            }
            .onAppear() {
                if countryNewsViewModel.listOfNews == nil {
                    countryNewsViewModel.getInitData()
                }
            }
        }
        .navigationTitle("Top News \(country.flag)")
    }
}

#Preview {
    CountryNewsView()
        .environmentObject(CountryNewsViewModel())
}
