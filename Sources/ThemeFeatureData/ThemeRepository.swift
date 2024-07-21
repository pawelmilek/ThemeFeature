//
//  ThemeStorageRepository.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/5/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import ThemeFeatureDomain

public struct ThemeRepository: Repository {
    private let dataSource: ThemeDataSource
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    public init(
        dataSource: ThemeDataSource,
        decoder: JSONDecoder,
        encoder: JSONEncoder
    ) {
        self.dataSource = dataSource
        self.decoder = decoder
        self.encoder = encoder
    }

    public func save(_ theme: ThemeState) async throws {
        let encoded = try encoder.encode(theme)
        try await dataSource.save(encoded)
    }

    public func saved() async throws -> ThemeState {
        guard let data = try await dataSource.saved() else { return .system }
        return try decoder.decode(ThemeState.self, from: data)
    }
}
