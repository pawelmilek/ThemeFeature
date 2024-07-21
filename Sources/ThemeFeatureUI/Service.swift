//
//  Service.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import ThemeFeatureDomain

public protocol Service {
    func save(theme: ThemeState) async throws
    func saved() async throws -> ThemeState
}
