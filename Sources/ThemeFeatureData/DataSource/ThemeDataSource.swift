//
//  ThemeDataSource.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public protocol ThemeDataSource {
    func save(_ theme: Data)
    func saved() -> Data?
}
