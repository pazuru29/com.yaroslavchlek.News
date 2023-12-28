//
//  NewsCard.swift
//  News
//
//  Created by Yaroslav Chlek on 26.12.2023.
//

import SwiftUI

struct NewsCard: View {
    var scheme: ColorScheme
    var news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageURL = news.urlToImage {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Image("defaultNews")
                        .resizable()
                }
                
            } else {
                Image("defaultNews")
                    .resizable()
            }
            Text(news.title ?? "")
                .foregroundStyle(.appText)
                .font(.title)
                .lineLimit(2)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
            Text(news.description ?? "")
                .lineLimit(3)
                .font(.title3)
                .foregroundStyle(.appSecondaryText)
                .fontWeight(.regular)
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 16)
        .background(.appBackgroundComponent)
        .multilineTextAlignment(.leading)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(height: 350)
        .contentShape(.rect)
        .shadow(color: scheme == .dark ? .clear : .appGray, radius: 10, y: 10)
    }
}

#Preview {
    NewsCard(scheme: .dark, news: News(source: Source(id: "id", name: "name"), author: "Author", title: "Title", description: "Description", url: "URL", urlToImage: nil, publishedAt: "12.10.2002", content: "Content"))
}
