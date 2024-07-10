//
//  ThemeService.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public protocol ThemeService {
    func save(theme: ThemeState)
    func saved() -> ThemeState
}
