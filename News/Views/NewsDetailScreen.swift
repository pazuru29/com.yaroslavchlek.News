//
//  NewsDetailScreen.swift
//  News
//
//  Created by Yaroslav Chlek on 27.12.2023.
//

import SwiftUI

struct NewsDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let news: News
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    VStack(alignment: .leading) {
                        ImageView(geometry: geometry)
                        
                        TextView(geometry: geometry)
                    }
                    .padding(.bottom, 16)
                    .multilineTextAlignment(.leading)
                    
                    AppOverlayView(geometry: geometry)
                }
            }
            .coordinateSpace(name: "MainScroll")
            .toolbar(.hidden, for: .navigationBar)
            .ignoresSafeArea(.container)
        }
    }
    
    func AppOverlayView(geometry: GeometryProxy) -> some View {
        return GeometryReader { proxy in
            let minY = proxy.frame(in: .named("MainScroll")).minY
            let progress = minY / (300 * 0.5)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundStyle(.appPrimaryTapped)
                        .padding(.all, 16)
                })
                .padding(.top, geometry.safeAreaInsets.top)
                Spacer()
            }
            .background(content: {
                Color.appBackground.opacity(-progress > 1 ? 1 : -progress)
            })
            .offset(y: -minY)
        }
    }
    
    func ImageView(geometry: GeometryProxy) -> some View {
        return GeometryReader { proxy in
            let minY = proxy.frame(in: .named("MainScroll")).minY
            let progress = minY / (300 * 0.8)
            
            ZStack(alignment: .topLeading) {
                VStack {
                    if let imageURL = news.urlToImage {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 300 + (minY > 0 ? minY : 0))
                                .clipped()
                        } placeholder: {
                            ShimmerView()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 300 + (minY > 0 ? minY : 0))
                                .clipped()
                        }
                    } else {
                        Image("defaultNews")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300 + (minY > 0 ? minY : 0))
                            .clipped()
                    }
                }
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                .appBackground.opacity(0 - progress),
                                .appBackground.opacity(0 - progress),
                                .appBackground.opacity(0 - progress),
                                .appBackground.opacity(0 - progress),
                                .appBackground.opacity(0 - progress),
                                .appBackground.opacity(0 - progress),
                                .appBackground.opacity(0.1 - progress),
                                .appBackground.opacity(0.3 - progress),
                                .appBackground.opacity(0.5 - progress),
                                .appBackground.opacity(0.8 - progress),
                                .appBackground.opacity(1)
                            ], startPoint: .top, endPoint: .bottom))
                    }
                })
            }
            .offset(y: -minY)
        }
        .frame(width:geometry.size.width, height: 300)
    }
    
    func TextView(geometry: GeometryProxy) -> some View {
        return VStack(alignment: .leading) {
            Text(news.title ?? "")
                .foregroundStyle(.appText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
            
            Text(news.description ?? "")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.appSecondaryText)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            Text(news.content ?? "")
                .font(.title3)
                .fontWeight(.regular)
                .foregroundStyle(.appSecondaryText)
                .padding(.horizontal, 16)
                .padding(.top, 16)
            
            if news.url != nil {
                Button("Read source") {
                    if let url = URL(string: news.url!) {
                        UIApplication.shared.open(url)
                    }
                }
                .buttonStyle(MainButtonStyle())
                .padding(.horizontal, 16)
                .padding(.top, 24)
            }
        }
        .frame(width: geometry.size.width)
    }
}
