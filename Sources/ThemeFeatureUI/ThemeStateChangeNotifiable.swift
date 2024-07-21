//
//  ThemeStateChangeNotifiable.swift
//  ThemeFeature
//
//  Created by Pawel Milek on 7/2/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import Foundation
import ThemeFeatureDomain

public protocol ThemeStateChangeNotifiable {
    func notify(themeState: ThemeState)
}
