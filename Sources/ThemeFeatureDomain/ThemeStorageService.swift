//
//  ThemeStorageService.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public struct ThemeStorageService: ThemeService {
    private let repository: Repository
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        repository: Repository,
        encoder: JSONEncoder,
        decoder: JSONDecoder
    ) {
        self.repository = repository
        self.encoder = encoder
        self.decoder = decoder
    }

    public func save(theme: ThemeState) {
        if let encoded = try? encoder.encode(theme) {
            repository.save(encoded)
        }
    }

    public func saved() -> ThemeState {
        if let data = repository.saved(),
           let theme = try? decoder.decode(ThemeState.self, from: data) {
            return theme
        }
        return .system
    }
}
