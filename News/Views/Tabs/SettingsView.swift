//
//  SettingsView.swift
//  News
//
//  Created by Yaroslav Chlek on 25.12.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var scheme
    @State private var changeTheme: Bool = false
    @AppConfiguration(\.username) var username
    @AppConfiguration(\.userAvatar) var userAvatar
    
    @State private var image = UIImage()
    
    @State var isCurrentCountrySelectorShow = false
    @State var isCategorySelectorShow = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                PrfileView()
                    .padding(.top, 24)
                SettingsButonSectionView()
                    .padding(.horizontal, 16)
                    .padding(.top, 64)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Profile")
        .toolbar {
            NavigationLink(destination: {
                EditProfileView(currentUsername: username)
            }, label: {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
            })
            .buttonStyle(IconButtonStyle())
        }
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
        .fullScreenCover(isPresented: $isCurrentCountrySelectorShow, content: {
            CountryView()
        })
        .fullScreenCover(isPresented: $isCategorySelectorShow, content: {
            CategoryView()
        })
        .onAppear {
            if userAvatar != nil {
                image = UIImage(data: userAvatar!) ?? UIImage()
            }
        }
    }
    
    @ViewBuilder
    func PrfileView() -> some View {
        VStack(spacing: 0) {
            if userAvatar == nil {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 86, height: 86)
                    .foregroundStyle(.appGray)
            } else {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 86, height: 86)
                    .clipShape(Circle())
            }
            Text(username)
                .foregroundStyle(.appText)
                .lineLimit(1)
                .font(.title2)
                .fontWeight(.regular)
                .padding(.horizontal, 50)
                .padding(.top, 24)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func SettingsButonSectionView() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("App settings")
                .font(.body)
                .fontWeight(.semibold)
            AppSettingsButton(assetName: "sun.min", title: "Display preference", subtitle: "Adjust your display", assetColor: .appAccientSecondaryColor1, bgColor: .appAccientColor1) {
                changeTheme.toggle()
            }
            AppSettingsButton(assetName: "globe.europe.africa", title: "Current country", subtitle: "Adjust your country", assetColor: .appAccientSecondaryColor2, bgColor: .appAccientColor2) {
                isCurrentCountrySelectorShow.toggle()
            }
            AppSettingsButton(assetName: "list.star", title: "Categories", subtitle: "Adjust your preferences", assetColor: .appAccientSecondaryColor3, bgColor: .appAccientColor3) {
                isCategorySelectorShow.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
