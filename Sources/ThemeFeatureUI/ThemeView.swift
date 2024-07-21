//
//  ThemeView.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 1/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//
// swiftlint:disable switch_case_alignment

import SwiftUI

public struct ThemeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject public var viewModel: ThemeViewModel
    @State private var gradientColor = Color.clear.gradient

    public let textColor: Color
    public let scheme: (dark: Color, light: Color)

    public init(
        viewModel: ThemeViewModel,
        textColor: Color,
        scheme: (dark: Color, light: Color)
    ) {
        self.viewModel = viewModel
        self.textColor = textColor
        self.scheme = scheme
    }

    public var body: some View {
        VStack(spacing: 35) {
            circleView
            descriptionView
            themePickerView
        }
        .frame(maxWidth: .infinity, maxHeight: viewModel.height)
        .background(Color(.systemBackground))
        .clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal, 15)
        .environment(\.colorScheme, colorScheme)
        .onChange(of: colorScheme, initial: true) {
            onThemeStateChanged()
        }
        .onChange(of: viewModel.selectedTheme) {
            onThemeStateChanged()
        }
        .onAppear {
            viewModel.sendScreenViewedAnalyticsEvent(
                className: "\(type(of: self))"
            )
        }
    }

    private func onThemeStateChanged() {
        viewModel.themeStateChanged("\(colorScheme)")
        setupGradient()
    }

    private func setupGradient() {
        gradientColor = switch viewModel.selectedTheme {
        case .system:
            colorScheme == .dark  ? scheme.dark.gradient : scheme.light.gradient

        case .light:
            scheme.light.gradient

        case .dark:
            scheme.dark.gradient
        }
    }

    private var circleView: some View {
        Circle()
            .fill(gradientColor)
            .frame(maxWidth: 150, maxHeight: 150)
            .mask {
                Rectangle()
                    .overlay {
                        Circle()
                            .offset(
                                x: viewModel.circleOffset.width,
                                y: viewModel.circleOffset.height
                            )
                            .blendMode(.destinationOut)
                            .animation(.bouncy, value: viewModel.circleOffset)
                    }
            }
    }

    private var descriptionView: some View {
        VStack(spacing: 10) {
            Text(viewModel.title)
                .font(.title3)
                .fontWeight(.bold)
            Text(viewModel.subtitle)
                .font(.subheadline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(textColor)
        .fontDesign(.monospaced)
    }

    private var themePickerView: some View {
        Picker(viewModel.pickerTitle, selection: $viewModel.selectedTheme) {
            ForEach(viewModel.themes) { item in
                Text(item.description)
                    .foregroundStyle(textColor)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
    }
}
