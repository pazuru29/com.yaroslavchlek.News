//
//  UserNews.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct UserNewsView: View {
    @Environment(\.colorScheme) private var scheme
    @AppConfiguration(\.categories) var categories
    
    @EnvironmentObject var userNewsViewModel: UserNewsViewModel
    
    @State var currentIndex: Int = 0
    
    @State var shouldScrollToTop: Bool = false
    let topItemId: String = "topItemId"
    
    var body: some View {
        ScrollViewReader { reader in
            CategorySelector(currentIndex: currentIndex, items: categories.map({ $0.rawValue })) { index in
                if currentIndex != index {
                    currentIndex = index
                    takeNews()
                }
                shouldScrollToTop = true
            }
            .padding(.vertical, 8)
            
            ScrollView {
                Color.appBackground
                    .frame(height: 8)
                    .id(topItemId)
                ForEach(userNewsViewModel.mapOfNews[categories[currentIndex]] ?? []) { news in
                    NavigationLink(destination: {
                        NewsDetailScreen(news: news)
                    }, label: {
                        NewsCard(scheme: scheme, news: news)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                    })
                }
            }
            .onChange(of: shouldScrollToTop, {
                withAnimation {  // add animation for scroll to top
                    reader.scrollTo(topItemId, anchor: .top) // scroll
                }
                shouldScrollToTop = false
            })
        }
        .navigationTitle("News by category")
        .onAppear() {
            takeNews()
        }
    }
    
    func takeNews() {
        if userNewsViewModel.mapOfNews[categories[currentIndex]] == nil {
            userNewsViewModel.getInitData(indexOfCategory: currentIndex)
        }
    }
}

//#Preview {
//    NavigationStack {
//        UserNewsView()
//    }
//    .environmentObject(UserNewsViewModel())
//}
