//
//  ThemeView.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 1/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//
// swiftlint:disable switch_case_alignment

import SwiftUI
import ThemeFeatureDomain

public struct ThemeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject public var viewModel: ThemeViewModel
    @State private var gradientColor: AnyGradient?

    public let textColor: Color
    public let darkScheme: Color
    public let lightScheme: Color

    public init(
        viewModel: ThemeViewModel,
        textColor: Color,
        darkScheme: Color,
        lightScheme: Color
    ) {
        self.viewModel = viewModel
        self.textColor = textColor
        self.darkScheme = darkScheme
        self.lightScheme = lightScheme
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
            setupGradient()
            setupCircleOffset()
        }
        .onChange(of: viewModel.selectedTheme) {
            setupGradient()
            setupCircleOffset()
            viewModel.sendColorSchemeSwitched(String(describing: colorScheme))
        }
        .onAppear {
            setupGradient()
            setupCircleOffset()
            viewModel.sendScreenViewed(className: "\(type(of: self))")
        }
        .animation(.bouncy, value: viewModel.circleOffset)
    }

    private func setupCircleOffset() {
        switch viewModel.selectedTheme {
        case .systemDefault:
            colorScheme == .dark
            ? viewModel.setDarkCircleOffset()
            : viewModel.setLightCircleOffset()

        case .light:
            viewModel.setLightCircleOffset()

        case .dark:
            viewModel.setDarkCircleOffset()
        }
    }

    private func setupGradient() {
        gradientColor = switch viewModel.selectedTheme {
        case .systemDefault:
            colorScheme == .dark 
            ? darkScheme.gradient
            : lightScheme.gradient

        case .light:
            lightScheme.gradient

        case .dark:
            darkScheme.gradient
        }
    }

    private var circleView: some View {
        Circle()
            .fill(gradientColor ?? darkScheme.gradient)
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
                Text(item.rawValue)
                    .foregroundStyle(textColor)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 40)
        .padding(.vertical, 10)
    }
}
