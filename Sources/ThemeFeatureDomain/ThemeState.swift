//
//  ThemeState.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 1/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//
// swiftlint:disable:identifier_name

import UIKit

public enum ThemeState: String, CaseIterable, Identifiable, Codable, CustomStringConvertible {
    case system
    case light
    case dark

    public var id: Self { self }

    public var description: String {
        switch self {
        case .system:
            "Default"
        case .dark:
            "Light"
        case .light:
            "Dark"
        }
    }
}
