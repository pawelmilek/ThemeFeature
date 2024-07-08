//
//  ThemeAnalyticsEvent.swift
//  Swifty Forecast
//
//  Created by Pawel Milek on 7/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public enum ThemeAnalyticsEvent {
    case colorSchemeSwitched(scheme: String)
    case screenViewed(className: String)

    public var name: String {
        switch self {
        case .colorSchemeSwitched:
            "color_scheme_switched"
        case .screenViewed:
            "screen_view"
        }
    }
    public var metadata: [String: Any] {
        switch self {
        case .colorSchemeSwitched(let scheme):
            [
                "color_scheme": scheme
            ]

        case .screenViewed(let className):
            [
                "screen_name": "Theme Screen",
                "screen_class": className
            ]
        }
    }
}
