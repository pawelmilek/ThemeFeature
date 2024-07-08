//
//  UserDefaultsThemeRepository.swift
//  Swifty Forecast
//
//  Created by Pawel Milek on 7/5/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import ThemeFeatureDomain

public struct UserDefaultsThemeRepository: ThemeRepository {
    private let key = "AppThemeKey"
    private let storage: UserDefaults

    public init(storage: UserDefaults) {
        self.storage = storage
    }

    public func save(theme: Theme) {
        if let encoded = try? JSONEncoder().encode(theme) {
            storage.set(encoded, forKey: key)
        }
    }

    public func saved() -> Theme {
        if let data = storage.object(forKey: key) as? Data,
           let theme = try? JSONDecoder().decode(Theme.self, from: data) {
            return theme
        }
        return .systemDefault
    }
}
