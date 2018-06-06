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

enum AboutType {

    case work
    case live
    case from
    case stutied
    case unknown

    static func typeFromSearver(_ type: String) -> AboutType {
        switch type {
        case "work":
            return .work
        case "live":
            return .live
        case "from":
            return .from
        case "stutied":
            return .stutied
        default :
            return .unknown
        }
    }

}
