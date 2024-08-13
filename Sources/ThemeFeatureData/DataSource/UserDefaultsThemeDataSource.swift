//
//  UserDefaultsThemeDataSource.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public struct UserDefaultsThemeDataSource: ThemeDataSource {
    private let key = "AppThemeKey"
    private let storage: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    public init(
        storage: UserDefaults,
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
    }

    public func save(_ theme: ThemeStateDTO) async throws {
        let encoded = try encoder.encode(theme)
        storage.set(encoded, forKey: key)
    }

    public func saved() async throws -> ThemeStateDTO? {
        guard let data = storage.object(forKey: key) as? Data else { return nil }
        return try decoder.decode(ThemeStateDTO.self, from: data)
    }
}
