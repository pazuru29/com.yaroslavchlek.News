//
//  String+Extensions.swift
//  News
//
//  Created by Yaroslav Chlek on 27.12.2023.
//

import Foundation

extension String {
    func removeCharCountSuffix() -> String {
        do {
            let regex = try NSRegularExpression(pattern: "\\[.*?\\s*\\+\\d+ chars\\]$", options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.utf16.count)
            let cleanedText = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
            return cleanedText
        } catch {
            print("Ошибка в регулярном выражении: \(error)")
            return self
        }
    }
}
