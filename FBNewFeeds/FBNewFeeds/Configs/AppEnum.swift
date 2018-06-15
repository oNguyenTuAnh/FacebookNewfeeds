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
    case studied
    case unknown

    static func typeFromSearver(_ type: String) -> AboutType {
        switch type {
        case "work":
            return .work
        case "live":
            return .live
        case "from":
            return .from
        case "studied":
            return .studied
        default :
            return .unknown
        }
    }

    func getCaptionAndIcon() -> (caption: String?, icon: UIImage?)? {
        switch self {
        case .work:
            return ("Work at", UIImage(named: "ic-work"))
        case .live:
            return ("Lives in", UIImage(named: "ic-live"))
        case .from:
            return ("From", UIImage(named: "ic-from"))
        case .studied:
            return ("Studied at", UIImage(named: "ic-studied"))
        default:
            return nil
        }
    }
}

enum Emoji: Int {

    case like
    case love
    case haha
    case wow
    case sad
    case agrry
    case unknown

    static func getEmoji(_ value: Int) -> Emoji {
        guard let emoji = Emoji(rawValue: value) else {
            return .unknown
        }
        return emoji
    }

    func getIconEmoji() -> UIImage? {
        switch self {
        case .like:
            return UIImage(named: "ic-like")?.imageWithColor(color: AppColor.selectedButtonColor)
        case .love:
            return UIImage(named: "ic-love")
        case .haha:
            return UIImage(named: "ic-haha")
        case .wow:
            return UIImage(named: "ic-wow")
        case .sad:
            return UIImage(named: "ic-sad")
        case .agrry:
            return UIImage(named: "ic-agrry")
        default:
            return UIImage(named: "ic-like")
        }
    }

    func getTextEmoji() -> String? {
        switch self {
        case .like, .unknown:
            return "Like"
        case .love:
            return "Love"
        case .haha:
            return "Haha"
        case .wow:
            return "Wow"
        case .sad:
            return "Sad"
        case .agrry:
            return "Agrry"
        }
    }

    func getColorTextEmoji() -> UIColor {
        switch self {
        case .like:
            return AppColor.selectedButtonColor
        case .love:
            return AppColor.lovelTextColor
        case .haha, .wow, .sad:
            return AppColor.hahaTextColor
        case .agrry:
            return AppColor.agrryTextColor
        default:
            return AppColor.defaultButtonColor
        }
    }

}
