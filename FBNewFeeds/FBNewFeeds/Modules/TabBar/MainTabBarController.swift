//
//  MainTabBarController.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

private struct Constants {

    static let imgNewsfeed = UIImage(named: "ic-news-feed")
    static let imgNotify   = UIImage(named: "ic-notify")
    static let imgFriend   = UIImage(named: "ic-friend-request")
    static let imgMenu     = UIImage(named: "ic-menu")

}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }

    private func setupTabbar() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = AppColor.iconTabbarSelectColor
        var listViewController: [UIViewController] = []
        let newsfeedViewController = BaseNavigationController(
            rootViewController: NewsfeedViewController.instantiateFromNib())
        newsfeedViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgNewsfeed,
            selectedImage: nil)
        listViewController.append(newsfeedViewController)

        let friendViewController = NotifyViewController.instantiateFromNib()
        friendViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgFriend,
            selectedImage: nil)
        listViewController.append(friendViewController)

        let notifyViewController = NotifyViewController.instantiateFromNib()
        notifyViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgNotify,
            selectedImage: nil)
        listViewController.append(notifyViewController)

        let menuViewController = NotifyViewController.instantiateFromNib()
        menuViewController.tabBarItem = UITabBarItem(title: "", image: Constants.imgMenu,
            selectedImage: nil)
        listViewController.append(menuViewController)

        for item in listViewController {
            item.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }

        viewControllers = listViewController
    }

}
