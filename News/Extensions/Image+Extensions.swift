//
//  Image+Extensions.swift
//  News
//
//  Created by Yaroslav Chlek on 28.12.2023.
//

import SwiftUI

extension Image {
    
func toData()-> Data {
    return self.toUIImage().jpegData(compressionQuality: 1)!
}

func save(for name: String) {
        UserDefaults.standard.setValue(self.toData(), forKey: name)
    }
}
