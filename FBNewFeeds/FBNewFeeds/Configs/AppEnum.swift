//
//  AppEnum.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/4/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation
import UIKit

enum PhotoLayoutType {

    case horizontal
    case vertical

    func getStackViewAxisLayout() -> UILayoutConstraintAxis {
        switch self {
        case .horizontal:
            return .vertical
        case .vertical:
            return .horizontal
        }
    }
}
