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

@MainActor
public final class ThemeViewModel: ObservableObject {
    @Published var selectedTheme = ThemeState.system
    @Published private(set) var themes = ThemeState.allCases
    @Published private(set) var title = "Appearance"
    @Published private(set) var subtitle = "Choose a day or night.\nCustomize your interface."
    @Published private(set) var pickerTitle = "Theme Settings"
    @Published private(set) var circleOffset = CGSize.zero
    private var cancellables = Set<AnyCancellable>()
    let height = CGFloat(410)

    private let service: Service
    private let notification: ThemeStateChangeNotifiable
    private let analytics: AnalyticsThemeSendable

    public init(
        service: Service,
        notification: ThemeStateChangeNotifiable,
        analytics: AnalyticsThemeSendable
    ) {
        self.service = service
        self.notification = notification
        self.analytics = analytics
        subscribePublishers()
        loadStoredThemeState()
    }

    private func subscribePublishers() {
        $selectedTheme
            .print()
            .dropFirst()
            .sink { [weak self] selectedTheme in
                self?.save(selectedTheme: selectedTheme)
            }
            .store(in: &cancellables)
    }

    private func loadStoredThemeState() {
        Task {
            do {
                self.selectedTheme = try await service.saved()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func themeStateChanged(_ systemSchemeName: String) {
        save(selectedTheme: selectedTheme)
        setupCircleOffset(by: systemSchemeName)
    }

    private func save(selectedTheme: ThemeState) {
        saveSelectedTheme(selectedTheme)
        notification.notify(themeState: selectedTheme)
        sendThemeSwitchedAnalyticsEvent(selectedTheme)
    }

    private func saveSelectedTheme(_ selectedTheme: ThemeState) {
        Task {
            do {
                try await service.save(theme: selectedTheme)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
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

    func sendScreenViewedAnalyticsEvent(className: String) {
        let event = ThemeAnalyticsEvent.screenViewed(className: className)
        analytics.send(
            name: event.name,
            metadata: event.metadata
        )
    }

    private func sendThemeSwitchedAnalyticsEvent(_ themeState: ThemeState) {
        let event = ThemeAnalyticsEvent.themeSwitched(theme: themeState.rawValue)
        analytics.send(
            name: event.name,
            metadata: event.metadata
        )
    }
}
