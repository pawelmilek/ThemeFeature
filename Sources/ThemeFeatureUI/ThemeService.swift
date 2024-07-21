//
//  ThemeService.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import ThemeFeatureDomain

public struct ThemeService: Service {
    private let repository: Repository

    public init(repository: Repository) {
        self.repository = repository
    }

    public func save(theme: ThemeState) async throws {
        try await repository.save(theme)
    }

    public func saved() async throws -> ThemeState {
        try await repository.saved()
    }
}
