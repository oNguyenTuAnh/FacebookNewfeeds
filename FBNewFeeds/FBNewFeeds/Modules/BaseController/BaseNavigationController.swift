//
//  BaseNavigationController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        delegate = self
        navigationBar.isOpaque = true
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.barTintColor = AppColor.blueColor
    }

}

extension BaseNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        if let currentVC = self.topViewController {
            let itemBack = UIBarButtonItem(title: "", style: .done, target: currentVC, action: nil)
            currentVC.navigationItem.backBarButtonItem = itemBack
        }
    }

}
