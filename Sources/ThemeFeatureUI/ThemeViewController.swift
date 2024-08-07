//
//  ThemeViewController.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 1/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import UIKit
import SwiftUI

public final class ThemeViewController: UIViewController {
    let viewModel: ThemeViewModel
    let textColor: Color
    let scheme: (dark: Color, light: Color)
    private var hostingViewController: UIHostingController<ThemeView>!

    public init(
        viewModel: ThemeViewModel,
        textColor: Color,
        scheme: (dark: Color, light: Color)
    ) {
        self.viewModel = viewModel
        self.textColor = textColor
        self.scheme = scheme
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let appearanceView = ThemeView(
            viewModel: viewModel,
            textColor: textColor,
            scheme: scheme
        )
        hostingViewController = UIHostingController(rootView: appearanceView)
        hostingViewController.view.backgroundColor = .clear
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        add(hostingViewController)
        setupAutolayoutConstraints()
        setupSheetPresentation()
    }

    private func setupSheetPresentation() {
        if let sheet = presentationController as? UISheetPresentationController {
            sheet.detents = [.custom(resolver: { [weak self] _ in self?.viewModel.height })]
            sheet.prefersGrabberVisible = false
        }
    }

    private func setupAutolayoutConstraints() {
        NSLayoutConstraint.activate([
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    deinit {
        debugPrint("File: \(#file), Function: \(#function), line: \(#line)")
    }
}

extension UIViewController {

  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }

  func remove() {
    guard parent != nil else {
      return
    }

    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }

}
