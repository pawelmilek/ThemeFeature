//
//  ThemeViewModel.swift
//  Swifty Forecast
//
//  Created by Pawel Milek on 6/28/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import Combine
import ThemeFeatureDomain

public final class ThemeViewModel: ObservableObject {
    @Published var selectedTheme: Theme
    @Published private(set) var themes = Theme.allCases
    @Published private(set) var title = "Appearance"
    @Published private(set) var subtitle = "Choose a day or night.\nCustomize your interface."
    @Published private(set) var pickerTitle = "Theme Settings"
    @Published private(set) var circleOffset = CGSize.zero
    private var cancellables = Set<AnyCancellable>()
    let height = CGFloat(410)

    private let repository: ThemeRepository
    private let notification: ThemeChangeNotifiable
    private let analytics: AnalyticsThemeSendable

    // TODO: Composite design pattern to reduce number of constructor injection
    public init(
        repository: ThemeRepository,
        notification: ThemeChangeNotifiable,
        analytics: AnalyticsThemeSendable
    ) {
        self.repository = repository
        self.notification = notification
        self.analytics = analytics
        self.selectedTheme = repository.saved()

        $selectedTheme
            .print()
            .sink { [weak self] selectedTheme in
                self?.repository.save(theme: selectedTheme)
                self?.notification.notify(newTheme: selectedTheme.rawValue)
            }
            .store(in: &cancellables)
    }

    func setLightCircleOffset() {
        circleOffset = CGSize(
            width: 150,
            height: -150
        )
    }

    func setDarkCircleOffset() {
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

    func sendColorSchemeSwitched(_ name: String) {
        let event = ThemeAnalyticsEvent.colorSchemeSwitched(scheme: name)
        analytics.send(
            name: event.name,
            metadata: event.metadata
        )
    }
}
