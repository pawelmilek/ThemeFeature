//
//  ThemeStateDTO+Mapping.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 8/13/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import ThemeFeatureDomain

extension ThemeStateDTO {
    func toDomain() -> ThemeState {
        switch self {
        case .system:
            ThemeState.system
        case .light:
            ThemeState.light
        case .dark:
            ThemeState.dark
        }
    }
}

extension ThemeState {
    func toDTO() -> ThemeStateDTO {
        switch self {
        case .system:
            ThemeStateDTO.system
        case .light:
            ThemeStateDTO.light
        case .dark:
            ThemeStateDTO.dark
        }
    }
}
