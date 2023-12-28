//
//  EditProfileView.swift
//  News
//
//  Created by Yaroslav Chlek on 28.12.2023.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppConfiguration(\.username) var username
    @AppConfiguration(\.userAvatar) var userAvatar
    
    @State var currentUsername: String
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            if image.pngData() == nil {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 86, height: 86)
                    .foregroundStyle(.appGray)
                    .onTapGesture {
                        showSheet = true
                    }
            } else {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 86, height: 86)
                    .clipShape(Circle())
                    .onTapGesture {
                        showSheet = true
                    }
            }
            
            TextField("Username", text: $currentUsername)
                .frame(maxWidth: .infinity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 50)
                .padding(.top, 36)
            
            Spacer()
            
            Button(action: {
                username = currentUsername
                userAvatar = image.resizeImage(targetSize: CGSize(width: 150, height: 150)).pngData()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            })
            .buttonStyle(MainButtonStyle())
            .padding(.horizontal, 50)
            .padding(.bottom, 48)
            .disabled(currentUsername.isEmpty)
        }
        .navigationTitle("Edit profile")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 48)
        .sheet(isPresented: $showSheet) {
            // Pick an image from the photo library:
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .onAppear {
            if userAvatar != nil {
                image = UIImage(data: userAvatar!) ?? UIImage()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(currentUsername: "Username")
    }
}
