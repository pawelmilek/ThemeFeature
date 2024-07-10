//
//  Theme.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/8/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation

public protocol ThemeSwitchable {
    func switchToSystem()
    func switchToDark()
    func switchToLight()
}

class Theme: ThemeSwitchable {
    private var state: ThemeState {
        didSet {
            notifyStateChanged(state)
        }
    }
    private var notifyStateChanged: (ThemeState) -> Void
    private(set) var circleOffset = CGSize.zero

    init(state: ThemeState, notifyStateChanged: @escaping (ThemeState) -> Void) {
        self.state = state
        self.notifyStateChanged = notifyStateChanged
    }

    func switchToSystem() {
        state = .system
    }

    func switchToDark() {
        state = .dark
    }

    func switchToLight() {
        state = .light
    }
}
