//
//  ThemeAnalyticsEvent.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public enum ThemeAnalyticsEvent {
    case themeSwitched(theme: String)
    case screenViewed(className: String)

    public var name: String {
        switch self {
        case .themeSwitched:
            "theme_switched"
        case .screenViewed:
            "screen_view"
        }
    }
    public var metadata: [String: Any] {
        switch self {
        case .themeSwitched(let theme):
            [
                "theme_name": theme
            ]

        case .screenViewed(let className):
            [
                "screen_name": "Theme Screen",
                "screen_class": className
            ]
        }
    }
}
