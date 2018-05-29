//
//  MainTabBarController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }

    private func setupTabbar() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        let newfeedsView = NewfeedsViewController.instantiateFromNib()
        newfeedsView.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "newFeeds"),
                                               selectedImage: #imageLiteral(resourceName: "newFeeds").imageWithColor(color: UIColor.fromHex("#254A85")))
        let newfeedsView2 = NewfeedsViewController.instantiateFromNib()
        newfeedsView2.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "newFeeds"),
                                                selectedImage: #imageLiteral(resourceName: "newFeeds").imageWithColor(color: UIColor.fromHex("#254A85")))
        viewControllers = [newfeedsView, newfeedsView2]
    }

}
