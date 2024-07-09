//
//  LocalThemeDataSource.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public struct LocalThemeDataSource: ThemeDataSource {
    private let key = "AppThemeKey"
    private let storage: UserDefaults

    public init(storage: UserDefaults) {
        self.storage = storage
    }

    public func save(_ theme: Data) {
        storage.set(theme, forKey: key)
    }

    public func saved() -> Data? {
        storage.object(forKey: key) as? Data
    }
}
