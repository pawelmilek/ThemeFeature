//
//  Theme.swift
//  Swifty Forecast
//
//  Created by Pawel Milek on 7/5/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public protocol ThemeRepository {
    func save(theme: Theme)
    func saved() -> Theme
}
