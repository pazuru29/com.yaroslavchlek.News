//
//  AppData.swift
//  News
//
//  Created by Yaroslav Chlek on 26.12.2023.
//

import SwiftUI

public class Defaults: ObservableObject {
    @AppStorage("isFirstTime") public var isFirstTime = true
    @AppStorage("country") public var country = Country.us
    @AppStorage("categories") public var categories = [Category]()
    @AppStorage("username") public var username = "Username"
    @AppStorage("userAvatar") public var userAvatar: Data?
    
    public static let shared = Defaults()
}

@propertyWrapper
public struct AppConfiguration<T>: DynamicProperty {
    @ObservedObject private var defaults: Defaults
    private let keyPath: ReferenceWritableKeyPath<Defaults, T>
    public init(_ keyPath: ReferenceWritableKeyPath<Defaults, T>, defaults: Defaults = .shared) {
        self.keyPath = keyPath
        self.defaults = defaults
    }

    public var wrappedValue: T {
        get { defaults[keyPath: keyPath] }
        nonmutating set { defaults[keyPath: keyPath] = newValue }
    }

    public var projectedValue: Binding<T> {
        Binding(
            get: { defaults[keyPath: keyPath] },
            set: { value in
                defaults[keyPath: keyPath] = value
            }
        )
    }
}
