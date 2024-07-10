//
//  ThemeViewModel.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 6/28/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import Combine
import ThemeFeatureDomain

public final class ThemeViewModel: ObservableObject {
    @Published var selectedTheme: ThemeState
    @Published private(set) var themes = ThemeState.allCases
    @Published private(set) var title = "Appearance"
    @Published private(set) var subtitle = "Choose a day or night.\nCustomize your interface."
    @Published private(set) var pickerTitle = "Theme Settings"
    @Published private(set) var circleOffset = CGSize.zero
    private var cancellables = Set<AnyCancellable>()
    let height = CGFloat(410)

    private let service: ThemeService
    private let notification: ThemeChangeNotifiable
    private let analytics: AnalyticsThemeSendable

    public init(
        service: ThemeService,
        notification: ThemeChangeNotifiable,
        analytics: AnalyticsThemeSendable
    ) {
        self.service = service
        self.notification = notification
        self.analytics = analytics
        self.selectedTheme = service.saved()

        $selectedTheme
            .print()
            .sink { [weak self] selectedTheme in
                self?.service.save(theme: selectedTheme)
                self?.notification.notify(newTheme: selectedTheme.rawValue)
                self?.sendColorSchemeSwitched(selectedTheme.rawValue)
            }
            .store(in: &cancellables)
    }

    func onSelectedThemeChanged(_ systemSchemeName: String) {
        service.save(theme: selectedTheme)
        notification.notify(newTheme: selectedTheme.rawValue)
        sendColorSchemeSwitched(selectedTheme.rawValue)
        setupCircleOffset(by: systemSchemeName)
    }

    private func setupCircleOffset(by systemSchemeName: String) {
        switch selectedTheme {
        case .system:
            if let mappedTheme = ThemeState(rawValue: systemSchemeName),
               mappedTheme == .dark {
                setDarkCircleOffset()
            } else {
                setLightCircleOffset()
            }

        case .dark:
            setDarkCircleOffset()

        case .light:
            setLightCircleOffset()
        }
    }

    private func setLightCircleOffset() {
        circleOffset = CGSize(
            width: 150,
            height: -150
        )
    }

    private func setDarkCircleOffset() {
        circleOffset = CGSize(
            width: 30,
            height: -25
        )
    }

    func sendScreenViewed(className: String) {
        let event = ThemeAnalyticsEvent.screenViewed(className: className)
        analytics.send(
            name: event.name,
            metadata: event.metadata
        )
    }

    private func sendColorSchemeSwitched(_ name: String) {
        let event = ThemeAnalyticsEvent.themeSwitched(theme: name)
        analytics.send(
            name: event.name,
            metadata: event.metadata
        )
    }
}
