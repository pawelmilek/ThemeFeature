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

    public init(
        dataSource: ThemeDataSource
    ) {
        self.dataSource = dataSource
    }

    public func save(_ theme: ThemeState) async throws {
        try await dataSource.save(theme.toDTO())
    }

    public func saved() async throws -> ThemeState {
        guard let theme = try await dataSource.saved() else { return .system }
        return theme.toDomain()
    }
}
