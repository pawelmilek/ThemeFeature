//
//  Repository.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/5/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public protocol Repository {
    func save(_ theme: ThemeState) async throws
    func saved() async throws -> ThemeState
}
