//
//  ThemeState.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 1/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//
// swiftlint:disable:identifier_name

import Foundation

public enum ThemeState: String, CaseIterable, Identifiable, CustomStringConvertible {
    case system = "default"
    case light = "light"
    case dark = "dark"

    public var id: Self { self }

    public var description: String {
        switch self {
        case .system:
            "Default"
        case .dark:
            "Dark"
        case .light:
            "Light"
        }
    }
}
