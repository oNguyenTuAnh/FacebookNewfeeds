//
//  Utilities.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/29/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class Utilities {

    static func changeRootViewController(_ view: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = view
        }
    }

}
