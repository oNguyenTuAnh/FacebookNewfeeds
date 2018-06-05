//
//  UIViewExtension.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/30/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

extension UIView {

    class func nibDefault() -> UINib {
        let nibName = String(describing: self)
        let nib = UINib.init(nibName: nibName, bundle: nil)
        return nib
    }

    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

}
